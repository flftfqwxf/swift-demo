//
//  Date+Format.swift
//  Ironhide
//
//  Created by Chris Huang on 16/11/30.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation


extension Date {
    
    func secondsFromNow() -> Int {
        
        return self.secondsFrom(date: Date())
    }
    
    func secondsFrom(date: Date) -> Int {
        
        let interval = self.timeIntervalSince(date)
        return Int(interval)
    }
    
}
