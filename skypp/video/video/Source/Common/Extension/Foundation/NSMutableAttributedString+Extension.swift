//
//  NSMutableAttributedString+Extension.swift
//  Ironhide
//
//  Created by Chris Huang on 16/11/10.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func addFont(_ font: UIFont) {
        
        let range = NSMakeRange(0, self.length)
        self.addFont(font, range: range)
        
    }
    
    func addFont(_ font: UIFont, range: NSRange) {
        
        self.addAttribute(NSFontAttributeName, value: font, range: range)
    }
    
    
    
    func addColor(_ color: UIColor) {
        
        let range = NSMakeRange(0, self.length)
        self.addColor(color, range: range)
    }
    
    func addColor(_ color: UIColor, range: NSRange) {
        
        self.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
    }
    
    
    func addParagraphStyle(_ style: NSParagraphStyle) {
        
        let range = NSMakeRange(0, self.length)
        self.addParagraphStyle(style, range: range)
    }
    
    func addParagraphStyle(_ style: NSParagraphStyle, range: NSRange) {
        
        self.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
    }
    
}
