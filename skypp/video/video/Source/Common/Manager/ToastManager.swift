//
//  ToastManager.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/6.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation

class IToastManager {
    
    static let sharedInstance = IToastManager()
    private init() {
        self.toastConfig()
    }
    
    private func toastConfig() {
        var style = ToastManager.shared.style
        style.shadowOpacity = 0.5
        style.cornerRadius = 3
        style.horizontalPadding = 20
        style.verticalPadding = 12
        style.activitySize = CGSize(width: 120, height: 96)
        ToastManager.shared.duration = 1.0
        ToastManager.shared.queueEnabled = false
        ToastManager.shared.position = ToastPosition.Center
        style.backgroundColor = UIColor.black
        style.messageColor = UIColor.white
        style.titleColor = UIColor.white
        ToastManager.shared.style = style
    }
    
    /**
     Toast Display in View
     */
    func makeToast(_ view: UIView, message: String , position: CGPoint, duration: TimeInterval = 2.0) {
        view.makeToast(message: message, duration: duration , position: position)
    }
    
    func makeToast(_ view: UIView, message: String, duration: TimeInterval = 1.5) {
        view.makeToast(message: message, duration: duration, position: ToastPosition.Center)
    }
    
    func makeButtomToast(_ view: UIView, message: String, duration: TimeInterval = 1.5) {
        view.makeToast(message: message, duration: duration, position: ToastPosition.Bottom)
    }
    
    func makeToastActivity(_ view: UIView, message: String? = nil) {
        view.makeToastActivity(position: .Center, msg: message)
    }
    
    func makeImageToastActivity(_ view: UIView, message: String? = nil) {
        view.makeToastActivity(position: .Center, msg: message, isImageLoading: true)
    }

    
}
