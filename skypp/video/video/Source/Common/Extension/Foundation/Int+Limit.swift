//
//  Int+Limit.swift
//  Ironhide
//
//  Created by Chris Huang on 16/11/29.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation

extension Int {
    
    func toLimitString() -> String{
        var limitString = String(self)
        if self > 999 {
            limitString = "999+"
        }
        return limitString
    }
    
}
