//
//  AlertManager.swift
//  Ironhide
//
//  Created by Chris Huang on 16/8/26.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import UIKit

class AlertManager {
    
    class func alert(_ title:String?, message:String?, actions:[String], completionHandler: @escaping ((_ selectedIndex:NSInteger) -> Void)){
        
        self._commonAction(style: .alert, title: title, message: message, actions: actions, completionHandler: completionHandler)
        
    }
    
    class func actionSheet(_ title:String?, actions:[String], completionHandler: @escaping ((_ selectedIndex: NSInteger) -> Void)) {
        
        self._commonAction(style: .actionSheet, title: title, message: nil, actions: actions, completionHandler: completionHandler)
        
    }
    
    
    private class func _commonAction(style:UIAlertControllerStyle, title:String?, message:String?, actions:[String], completionHandler: @escaping ((_ selectedIndex:NSInteger) -> Void)){
    
        let controller = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for index in 0 ..< actions.count {
            let action  = UIAlertAction(title: actions[index], style: .default, handler: { (actions) in
                
                completionHandler(index)
            })
            controller.addAction(action)
        }
        if style == .actionSheet {
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller.addAction(cancel)
        }
        
        let topController = UIApplication.topViewController()
        topController?.present(controller, animated: true, completion: nil)
    }
}

