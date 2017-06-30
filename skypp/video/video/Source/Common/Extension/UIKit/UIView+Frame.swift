//
//  UIView+Frame.swift
//  Ironhide
//
//  Created by Chris Huang on 16/8/19.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit



extension UIView {
    
    public var originX : CGFloat {
        
        get {
            return self.frame.origin.x
        }
        
        set {
            var newFrame = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
        
    }
    
    
    public var originY : CGFloat {
        
        get {
            return self.frame.origin.y
        }
        
        set {
            var newFrame = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
    }
    
    
    public var sizeW : CGFloat {
        
        get {
            return self.frame.size.width
        }
        
        set {
            var newFrame = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
    }
    
    public var sizeH : CGFloat {
        
        get {
            return self.frame.size.height
        }
        
        set {
            var newFrame = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
    }
    
    
    public var centerXX : CGFloat {
        
        get {
            return self.center.x
        }
        set {
            var newCenter = self.center
            newCenter.x = newValue
            self.center = newCenter
        }
    }
    
    public var centerYY : CGFloat {
        get {
            return self.center.y
        }
        set {
            var newCenter = self.center
            newCenter.y = newValue
            self.center = newCenter
        }
    }
    
}
