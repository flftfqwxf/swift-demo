//
//  Device+info.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/10/26.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {

    static func appVersion() -> String {
        if let version = (Bundle.main.infoDictionary as NSDictionary?)?.object(forKey: "CFBundleShortVersionString") {
            return String(describing: version)
        }
        return ""
    }
    
    static func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    static func systemName() -> String {
        return UIDevice.current.systemName
    }
    
    static func phoneModel() -> String {
        return UIDevice.current.model
    }
    
    static func resolution() -> String {
        return "\(UIScreen.main.bounds.size)"+" \(UIScreen.main.scale)"
    }

}
