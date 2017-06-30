//
//  SocialManager.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/4.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON


enum SocialType: Int {
    case WeChat = 1
    case QQ
    case SinaWeibo
}

enum SocialShareType {
    case QQ
    case WeChat
    case SinaWeiBo
    case QQZone
    case WeChatFriends
    case WeChatFavorite
    case More
}


class ThirdLoginObject {
    var type: Int = 0
    var access_token:  String = ""
    var refresh_token: String = ""
    var expires_in:    String = ""
    
    var user_name: String = ""
    var signature: String = ""
    var avatar:    String = ""
    var gender:    String = "0"
    var openid:    String = ""
    var unionid:   String = ""
    var location:  String = ""
}


class SocialManager {
    static private let SocialErrorCode = -99999
    static let sharedInstance = SocialManager()
    
}
