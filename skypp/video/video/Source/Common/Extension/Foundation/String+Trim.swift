//
//  String+Trim.swift
//  Ironhide
//
//  Created by Chris Huang on 16/9/8.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation

extension String {
    
    
    func innerTrim() -> String {
        
        let nsString = self as NSString
        let range = NSMakeRange(0, nsString.length)
        return nsString.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression, range: range)
        
    }
    
    func fullTrim() -> String {
        
        return self.innerTrim().trim()
    }
    
}
