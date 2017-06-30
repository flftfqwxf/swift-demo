//
//  KeyboardManager.swift
//  Ironhide
//
//  Created by Chris Huang on 16/10/21.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation

class KeyboardManager : NSObject {
    
    var keyboardHeight:CGFloat = 0.0
    
    var keyboardAppearHandler: (()->Void)?
    var keyboardDisappearHandler: (()->Void)?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override init() {
        
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    
    func keyboardWillAppear(notification: NSNotification) {
        
        if let endFrameValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let endFrame = endFrameValue.cgRectValue
            // if beginFrame.size.height > 44.0 && (beginFrame.origin.y - endFrame.origin.y) > 0 { //第三方键盘要call三次这个方法，只处理最后一次
           
            keyboardHeight = endFrame.size.height
            self.keyboardAppearHandler?()
//            }
        }
        
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        
        keyboardHeight = 0.0
        
        self.keyboardDisappearHandler?()
    }
    
    
}
