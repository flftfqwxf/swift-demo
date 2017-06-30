//
//  NetworkStateManager.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/13.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import UIKit
final class NetworkMonitor {
    
    /// 网络连接数
    var netWorkNumber = 0
    
    class var sharedInstance : NetworkMonitor {
        struct Static {
            static let instance : NetworkMonitor = NetworkMonitor()
        }
        return Static.instance
    }

    /**
        @desc:开始网络访问
     */
    func startNetworking() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        netWorkNumber += 1
    }
    
    /**
        @desc:结束网络访问
     */
    func endNetworking() {
        netWorkNumber -= 1
        if netWorkNumber == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
