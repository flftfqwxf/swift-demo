//
//  UIView+FrameAdjust.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/10/26.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit
import Foundation


extension UIView {

    func x() -> CGFloat {
        return self.frame.origin.x
    }
    
    func setX(x: CGFloat) {
        self.frame = CGRect(x: x, y: self.y(), width: self.width(), height: self.height())
    }
    
    func y() -> CGFloat {
        return self.frame.origin.y
    }

    
    func setY(y: CGFloat) {
        self.frame = CGRect(x: self.x(), y: y, width: self.width(), height: self.height())
    }
    
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    func setWidth(width: CGFloat) {
        self.frame = CGRect(x: self.x(), y: self.y(), width: width, height: self.height())
    }


    func height() -> CGFloat {
        return self.frame.size.height
    }
    
    func setHeight(height: CGFloat) {
        self.frame = CGRect(x: self.x(), y: self.y(), width: self.width(), height: height)
    }

}
