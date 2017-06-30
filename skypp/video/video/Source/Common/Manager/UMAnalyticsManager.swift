//
//  UMAnalyticsManager.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/12.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation

final class UMAnalyticsManager {
    
    /**
     配置友盟统计
     */
    class func start()  {
       let config = UMAnalyticsConfig.sharedInstance()
        config?.appKey = Umeng_App_Key
        config?.channelId = "App store"
        config?.eSType = .E_UM_NORMAL
        MobClick.start(withConfigure: config)
        MobClick.setCrashReportEnabled(true)
    }
    
    
    // MARK: 页面统计
    
    /**
     进入某个页面
     
     - parameter pageName: 页面名称
     */
    class func beginLogPageView(pageName: String) {
        MobClick.beginLogPageView(pageName)
    }
    
    
    /**
    结束某个页面
     
     - parameter pageName: 页面名称
     */
    class func endLogPageView(pageName: String) {
        MobClick.endLogPageView(pageName)
    }
    
    
    
    // MARK: 事件统计
    
    
}
