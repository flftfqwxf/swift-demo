//
//  AccountManager.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/1.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit
import ObjectMapper

let ACCOUNT_SESSION_SERVICE_NAME = "IronHide_Account_Session"

class AccountManager: NSObject {
    
    var currentUser: User?
    
    class var sharedInstance : AccountManager {
        struct Static {
            static let instance : AccountManager = AccountManager()
        }
        return Static.instance
    }
    
    override init() {
        super.init()
        self.initalizeUser()
    }
    
    func initalizeUser() {
        if let userJSON = UserDefaults.standard.string(forKey: ACCOUNT_SESSION_SERVICE_NAME) {
            if let user = Mapper<User>().map(JSONString: userJSON) {
                self.currentUser = user
            } else {
                self.currentUser = nil
                UserDefaults.standard.removeObject(forKey: ACCOUNT_SESSION_SERVICE_NAME)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func bindPush() {
        if let user = currentUser {
            MiPushSDK.setAccount(String(user.user_id) )
            MiPushSDK.unsubscribe("guest")
            MiPushSDK.subscribe("user")
        } else {
            MiPushSDK.unsubscribe("user")
            MiPushSDK.subscribe("guest")
        }
    }
    
    func loginUser(_ user : User) {
        currentUser = user
        saveUser()
        bindPush()
        EventBus.postToMainThread(EventType.LoginStateChanged.rawValue, sender: nil)
        if user.has_unread_notification {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationNewMsgShow), object: nil, userInfo: nil)
        }
    }
    
    func saveUser() {
        if let user = currentUser {
            UserDefaults.standard.set(Mapper<User>().toJSONString(user, prettyPrint: true), forKey: ACCOUNT_SESSION_SERVICE_NAME)
            UserDefaults.standard.synchronize()
        }
    }
    
    func userLoginOut() {
        if let user = self.currentUser {
            MiPushSDK.unsetAccount(String(user.user_id))
            MiPushSDK.unsubscribe("user")
            MiPushSDK.subscribe("guest")
            UserDefaults.standard.removeObject(forKey: ACCOUNT_SESSION_SERVICE_NAME)
            UserDefaults.standard.synchronize()
            ReadRecordCacheManager.sharedInstance.cleanCurrentTableData()
            self.currentUser = nil
        }
        EventBus.postToMainThread(EventType.LoginStateChanged.rawValue, sender: nil)
    }

    func isLogin() -> Bool {
        return self.currentUser != nil
    }

    func setDisturb(isdisturb: Bool) {
        self.currentUser?.disturb = isdisturb
        self.saveUser()
    }
    
    func updateUser(user : User) {
        if let _user = self.currentUser {
            let token = _user.access_token
            user.access_token = token
            self.currentUser = user
            self.saveUser()
        }
    }
    
    func userLoginTimeOut() {
        if self.isLogin() {
            self.userLoginOut()
            let loginVC = LoginVC()
            UIApplication.topVisibleViewController()?.present(InteractiveNavigationController(rootViewController: loginVC), animated: true, completion: {
                IToastManager.sharedInstance.makeToast(loginVC.view, message: "用户登录过期,请重新登录。")
            })
        }
    }
}
