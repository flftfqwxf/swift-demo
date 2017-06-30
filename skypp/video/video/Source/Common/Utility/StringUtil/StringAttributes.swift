//
//  StringAttributes.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/10/26.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit
import Foundation
import CoreText

class StringAttributes: NSObject {
    
    static func attributeFont(font: UIFont, antTextColor color: UIColor, linespace: CGFloat, lineBreakMode: CTLineBreakMode) -> [String: Any] {
        
        let textColor: UIColor = color
        let showFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        var alignment: CTTextAlignment = .justified
        var showlinespace: CGFloat = linespace
        var showlineBreakMode: CTLineBreakMode = lineBreakMode

        let alignmentSetting = [ CTParagraphStyleSetting(spec: .alignment, valueSize: MemoryLayout.size(ofValue: alignment), value: &alignment), CTParagraphStyleSetting(spec: .lineSpacingAdjustment, valueSize: MemoryLayout.size(ofValue: showlinespace), value: &showlinespace),  CTParagraphStyleSetting(spec: .lineBreakMode, valueSize: MemoryLayout.size(ofValue: showlineBreakMode), value: &showlineBreakMode)]
        let style: CTParagraphStyle = CTParagraphStyleCreate(alignmentSetting, 3)
        var attributes = [String: Any]()
        attributes[kCTForegroundColorAttributeName as String] = textColor.cgColor
        attributes[kCTFontAttributeName as String] = showFont
        attributes[kCTParagraphStyleAttributeName as String] = style
    
        return attributes
    }
    
    static func defaultAttribute(_ string: String, font: UIFont, antTextColor color: UIColor, linespace: CGFloat, lineBreakMode: NSLineBreakMode) -> NSMutableAttributedString {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = linespace
        style.lineBreakMode = lineBreakMode
        style.alignment = .justified
        
        let returnAttributedText = NSMutableAttributedString(string: string)
        returnAttributedText.addColor(color)
        returnAttributedText.addFont(font)
        returnAttributedText.addParagraphStyle(style)
        return returnAttributedText
    }
    
}

