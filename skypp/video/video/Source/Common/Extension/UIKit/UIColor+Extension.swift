//
//  UIColor+Extension.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/2.
//  Copyright © 2016年 Istuary. All rights reserved.
//
import UIKit

extension UIColor {
    convenience init(argb: Int64) {
        let red = CGFloat((argb & 0x00ff0000) >> 16) / 255.0
        let green = CGFloat((argb & 0x0000ff00) >> 8) / 255.0
        let blue = CGFloat(argb & 0x000000ff) / 255.0
        let alpha = CGFloat(argb >> 24) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(argbStr: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if argbStr.hasPrefix("0x") {
            
            
            let index   = argbStr.index(argbStr.startIndex, offsetBy: 2)
            let hex     = argbStr.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        
        self.init(r:r,g:g,b:b,a:1.0)
    }
    
    convenience init(r: Int, g: Int, b: Int,a: CGFloat) {
        
        let red     = CGFloat(r)/255.0
        let green   = CGFloat(g)/255.0
        let blue    = CGFloat(b)/255.0
        
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
    
}
