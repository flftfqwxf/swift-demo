//
//  PropertyAnimation.swift
//  SwiftDemo
//
//  Created by Chris Huang on 16/11/14.
//  Copyright © 2016年 istuary. All rights reserved.
//

import Foundation
import UIKit

class PropertyAnimation: NSObject{
    
    var duration: CGFloat = 0
    var displayLink: CADisplayLink?
    var callback: ((_ rate: CGFloat, _ finished: Bool) -> Void)?
    
    private var startTime: TimeInterval = 0.0
    
    
    func start() {
        
        self.stop()
        self.startTime = NSDate.timeIntervalSinceReferenceDate
        self.displayLink = CADisplayLink(target: self, selector: #selector(updateDisplay))
        self.displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        
    }
    
    func stop() {
    
        if self.displayLink != nil{
            self.displayLink?.invalidate()
            self.displayLink = nil
        }
    }
    
    
    func updateDisplay(displayLink: CADisplayLink) {
        
        let now = NSDate.timeIntervalSinceReferenceDate
        let passedTime = now - self.startTime
        
        if CGFloat(passedTime) < self.duration {
            let rate = CGFloat(passedTime)/duration
            self.callback?(rate, false)
        }
        else{
            self.callback?(1, true)
            self.stop()
        }
        
    }
    
    
}
