//
//  NSMutableParagraphStyle+DefaultStyle.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/11/1.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit
import Foundation

extension NSMutableAttributedString {
    
    class func defaltStyle(sourceString: String, font: UIFont, textColor: UIColor, lineSpace: CGFloat) -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = .justified
        paragraphStyle.lineBreakMode = .byCharWrapping
        
        let attributedString = NSMutableAttributedString(string: sourceString)
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, (sourceString as NSString).length))
        attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, (sourceString as NSString).length))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: NSMakeRange(0, (sourceString as NSString).length))
        return attributedString
    }
    
    class func defaltAttribute(sourceString: String, font: UIFont, textColor: UIColor, lineSpace: CGFloat) -> [String: Any] {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = .justified
        paragraphStyle.lineBreakMode = .byCharWrapping
        
        var attributes = [String: Any]()
        attributes[NSForegroundColorAttributeName] = textColor
        attributes[NSFontAttributeName] = font
        attributes[NSParagraphStyleAttributeName as String] = paragraphStyle
        return attributes
    }
}
