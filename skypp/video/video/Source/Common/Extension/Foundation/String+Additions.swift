//
//  String+additions.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/10/26.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit
import Foundation
import CoreText

extension String {
    
    // 查找、比较、替换
    
    func compareTo(comp: String) -> Int {
        let result: ComparisonResult = self.compare(comp)
        if result == ComparisonResult.orderedSame {
            return 0
        }
        return result == ComparisonResult.orderedAscending ? -1 : 1
    }
    
    
    func compareToIgnoreCase(comp: String) -> Int {
        return self.lowercased().compareTo(comp: comp)
    }
    
    
    func contains(subString: String) -> Bool {
        let rang = (self as NSString).range(of: subString)
        return rang.location != NSNotFound
    }
    
    
    func endsWith(subString: String) -> Bool {
        let rang = (self as NSString).range(of: subString)
        return rang.location == self.characters.count - subString.characters.count
    }
    
    
    func startsWith(subString: String) -> Bool {
        let rang = (self as NSString).range(of: subString)
        return rang.location == 0
    }
    
    
    func indexOf(subString: String) -> Int {
        let rang = (self as NSString).range(of: subString, options: NSString.CompareOptions.caseInsensitive)
        return rang.location == NSNotFound ? -1 : rang.location
    }
    
    
    func indexOf(subString: String, startingFrom index: Int) -> Int {
        return index + (self as NSString).substring(from: index).indexOf(subString: subString)
    }
    
    
    func lastIndexOf(subString: String) -> Int {
        let rang = (self as NSString).range(of: subString, options: NSString.CompareOptions.backwards)
        return rang.location == NSNotFound ? -1 : rang.location
    }
    
    
    func lastIndexOf(subString: String, startingFrom: Int) -> Int {
        let temp = (self as NSString).substring(from: startingFrom)
        return temp.lastIndexOf(subString: subString)
    }
    
    
    func substringFromIndex(from: Int, to: Int) -> String {
        let rang = NSRange(location: from, length: to - from)
        return (self as NSString).substring(with: rang)
    }

    
    // 去除二端空格
    func trim()->String{
        let temp = trimmingCharacters(in: NSCharacterSet.whitespaces)
        return temp.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    // 字符串分割
    func split(keyToken: String, limit maxResults: Int = 0) -> NSArray {
        let result = NSMutableArray()
        var buffer = self
        while buffer.contains(keyToken) {
            if maxResults > 0 && result.count == maxResults - 1 {
                break
            }
            let matchIndex = buffer.indexOf(subString: keyToken)
            let nextPart = buffer.substringFromIndex(from: 0, to: matchIndex)
            buffer = (buffer as NSString).substring(from: matchIndex + keyToken.characters.count)
            result.add(nextPart)
        }
        if buffer.characters.count > 0 {
            result.add(buffer)
        }
        return result
    }
    
    
    func split(token: String) -> NSArray {
        return self.split(keyToken: token, limit: 0)
    }
    
    
    // 字符串替换
    func replace(target: String, withString replacement: String) -> String {
        return (self as NSString).replacingOccurrences(of: target, with: replacement)
    }
    
    
    // ================= 绘制 显示计算 ===============
    
    func lineNumberOfText(width: CGFloat, withFont font: UIFont, antTextColor color: UIColor, lineSpace: CGFloat, lineBreakMode: NSLineBreakMode) -> Int {
        
        let allSize = self.sizeWithConstrainedToSize(size: CGSize(width: width, height: CGFloat(Int.max)), withFont: font, antTextColor: color, lineSpace: lineSpace, lineBreakMode: lineBreakMode)
        
        let attributedStr = StringAttributes.defaultAttribute(self, font: font, antTextColor: color, linespace: lineSpace, lineBreakMode: lineBreakMode)
        let frameRect = CGRect(origin: CGPoint.zero, size: allSize)

        let framePath: CGMutablePath = CGMutablePath()
            framePath.addRect(frameRect)
        let framesetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attributedStr)
        let fullStringRange: CFRange = CFRangeMake(0, CFAttributedStringGetLength(attributedStr))
        let aFrame: CTFrame = CTFramesetterCreateFrame(framesetter, fullStringRange, framePath, nil)
        let lines: CFArray = CTFrameGetLines(aFrame)
        let count: CFIndex = CFArrayGetCount(lines)
        return count
    }
    
    func sizeWithConstrainedToWidth(width: CGFloat, withFont font: UIFont, antTextColor color: UIColor, maxLineNumber: Int, lineSpace: CGFloat, lineBreakMode: NSLineBreakMode) -> CGSize {

        let allSize = self.sizeWithConstrainedToSize(size: CGSize(width: width, height: CGFloat(Int.max)), withFont: font, antTextColor: color, lineSpace: lineSpace, lineBreakMode: lineBreakMode)
        let attributedStr = StringAttributes.defaultAttribute(self, font: font, antTextColor: color, linespace: lineSpace, lineBreakMode:lineBreakMode)
        
        let frameRect = CGRect(origin: CGPoint.zero, size: allSize)
        let framePath: CGMutablePath = CGMutablePath()
            framePath.addRect(frameRect)
        let framesetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attributedStr)
        let fullStringRange: CFRange = CFRangeMake(0, CFAttributedStringGetLength(attributedStr))
        let aFrame: CTFrame = CTFramesetterCreateFrame(framesetter, fullStringRange, framePath, nil)
        let lines: CFArray = CTFrameGetLines(aFrame)
        let count: CFIndex = CFArrayGetCount(lines)
        if count > maxLineNumber {
            var maxString: String = kEmptyString
            for i in 0..<maxLineNumber {
                let line: CTLine = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
                let lineRange = CTLineGetStringRange(line)
                let rang = NSRange(location: lineRange.location, length: lineRange.length)
                let lineString = (self as NSString).substring(with: rang)
                maxString.append(lineString)
            }
            
            let maxSize = maxString.sizeWithConstrainedToSize(size: CGSize(width: width, height: CGFloat(Int.max)), withFont: font, antTextColor: color, lineSpace: lineSpace, lineBreakMode: lineBreakMode)
            return maxSize
        } else {
            return allSize
        }
    }
    
    func sizeWithConstrainedToWidth(width: CGFloat, withFont font: UIFont, antTextColor color: UIColor,  lineSpace: CGFloat, lineBreakMode: NSLineBreakMode) -> CGSize {
        
        return self.sizeWithConstrainedToSize(size: CGSize(width: width, height: CGFloat(Int.max)), withFont: font, antTextColor: color, lineSpace: lineSpace, lineBreakMode: lineBreakMode)
    }
    
    func sizeWithConstrainedToSize(size: CGSize, withFont font: UIFont,antTextColor color: UIColor, lineSpace: CGFloat, lineBreakMode: NSLineBreakMode) -> CGSize {
                
        let attributedStr = StringAttributes.defaultAttribute(self, font: font, antTextColor: color, linespace: lineSpace, lineBreakMode: lineBreakMode)
        let framesetter = CTFramesetterCreateWithAttributedString(attributedStr)
        let result = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, attributedStr.length), nil, size, nil)
        return CGSize(width: result.width, height: ceil(result.height))
    }
    
    func drawInContext(context: CGContext, withPosition position: CGPoint, andFont font: UIFont, andTextColor color: UIColor, andHeight height: CGFloat, andWidth width: CGFloat, lineSpace: CGFloat, andlineBreakMode lineBreakMode: NSLineBreakMode) {
        
        let size = CGSize(width: width, height: height)        
        let attributedStr = StringAttributes.defaultAttribute(self, font: font, antTextColor: color, linespace: lineSpace, lineBreakMode: lineBreakMode)
        let frameRect = CGRect(x: position.x, y: height - position.y - size.height, width: size.width, height: size.height)
        self.drawString(attString: attributedStr, inRect: frameRect, inContext: context, height: height)
    }
    
    
    private func drawString(attString: CFAttributedString, inRect frameRect: CGRect, inContext context: CGContext, height: CGFloat) {


        context.saveGState()
        context.textMatrix = CGAffineTransform.identity
        context.translateBy(x: 0, y: height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let framePath: CGMutablePath = CGMutablePath()
        framePath.addRect(frameRect)
        
        let framesetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attString)
        let fullStringRange: CFRange = CFRangeMake(0, CFAttributedStringGetLength(attString))
        let aFrame: CTFrame = CTFramesetterCreateFrame(framesetter, fullStringRange, framePath, nil)
        let lines: CFArray = CTFrameGetLines(aFrame)
        let count: CFIndex = CFArrayGetCount(lines)
        
        var origins = Array<CGPoint>(repeating: CGPoint.zero, count: count)
        CTFrameGetLineOrigins(aFrame, CFRangeMake(0, count), &origins)
        
        if count > 0 {
            
            for i in 0..<count - 1 {
                context.textPosition = CGPoint(x:origins[i].x + frameRect.origin.x, y:  origins[i].y + frameRect.origin.y)
                let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
                CTLineDraw(line, context)
            }
            
            let lastOrigin = origins[count - 1]
            let lastLine = unsafeBitCast(CFArrayGetValueAtIndex(lines, count - 1), to: CTLine.self)
            var effectiveRange = CFRange(location: 0, length: 0)
            let stringAttrs: CFDictionary = CFAttributedStringGetAttributes(attString, 0, &effectiveRange)
            
            let truncationString: CFAttributedString = CFAttributedStringCreate(nil, "\u{2026}" as CFString!, stringAttrs)
            let truncationToken: CTLine = CTLineCreateWithAttributedString(truncationString)
            
            var rng: CFRange = CFRangeMake(CTLineGetStringRange(lastLine).location, 0)
            rng.length = CFAttributedStringGetLength(attString) - rng.location
            
            let longString: CFAttributedString = CFAttributedStringCreateWithSubstring(nil, attString, rng)
            let longLine: CTLine = CTLineCreateWithAttributedString(longString)
            
            let showtruncated:CTLine!
            if let truncated: CTLine = CTLineCreateTruncatedLine(longLine, Double(frameRect.size.width), CTLineTruncationType.end, truncationToken) {
                showtruncated = truncated
            } else {
                showtruncated = lastLine
            }
            context.textPosition = CGPoint(x: lastOrigin.x + frameRect.origin.x, y: lastOrigin.y + frameRect.origin.y)
            CTLineDraw(showtruncated, context)
        }
        context.restoreGState()
    }
    
    func drawInContext(context: CGContext, withPosition position: CGPoint, andFont font: UIFont, andTextColor color: UIColor, andHeight height: CGFloat,lineSpace: CGFloat, andlineBreakMode lineBreakMode: NSLineBreakMode) {
        self.drawInContext(context: context, withPosition: position, andFont: font, andTextColor: color, andHeight: height, andWidth: CGFloat(Int.max),lineSpace: lineSpace, andlineBreakMode: lineBreakMode)
    }
}
