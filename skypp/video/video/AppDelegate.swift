//
//  AppDelegate.swift
//  video
//
//  Created by leixianhua on 5/15/17.
//  Copyright © 2017 leixianhua. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let rect=UIScreen.main.bounds
        let mainWindow = UIWindow(frame: rect)
        mainWindow.rootViewController=UINavigationController(rootViewController: IndexViewController())
//        mainWindow.rootViewController=IndexViewController()

        window=mainWindow
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //当应用程序即将从活动状态移动到非活动状态时发送。 某些类型的暂时中断（例如来电或短信）或用户退出应用程序并开始转换到背景状态时，可能会发生这种情况。
        //使用此方法暂停正在执行的任务，禁用计时器，并使图形渲染回调无效。 游戏应该使用这种方法暂停游戏。
    }

    func applicationDidEnterBacdkground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //在应用程序处于非活动状态时重新启动任何已暂停（或尚未启动）的任务。 如果应用程序以前在后台，请选择刷新用户界面。
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //当应用程序即将终止时调用。 酌情保存数据。 另请参见applicationDidEnterBackground :.
    }


}

