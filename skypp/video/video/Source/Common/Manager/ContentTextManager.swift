//
//  ContentTextManager.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/10/26.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit

class ContentTextManager: NSObject {

    var ranges = [String]()
    var framesDict   = [String: NSValue]()
    var relationDict = [String: [String]]()
    var contentString: String = kEmptyString
    
    private var textColor: UIColor!
    private var font:    UIFont!
    private var xOffset: CGFloat!
    private var yOffset: CGFloat!
    
    func highlightText(coloredString:  NSMutableAttributedString) -> NSMutableAttributedString {
        
        do {
            let textString = coloredString.string
            let range = NSMakeRange(0, (textString as NSString).length)
            let linkDetector: NSDataDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = linkDetector.matches(in: textString, options: NSRegularExpression.MatchingOptions.reportProgress, range: range)
            for match in matches {
                self.ranges.append(NSStringFromRange(match.range))
                let highlightColor: UIColor = kThemeColorOrange
                coloredString.addAttribute(NSForegroundColorAttributeName, value: highlightColor, range: match.range)
            }
            return coloredString
        } catch {
            return coloredString
        }
    }
    
    
    func highlightTextRange(range: NSRange ,coloredString:  NSMutableAttributedString) -> NSMutableAttributedString {
        
        self.ranges.append(NSStringFromRange(range))
        let highlightColor: UIColor = kThemeColorOrange
        coloredString.addAttribute(NSForegroundColorAttributeName, value: highlightColor, range: range)
        return coloredString
    }

    
    func setText(text: String, withContext context: CGContext, range: NSRange, contentSize size: CGSize, backgroundColor: UIColor, font: UIFont, textColor: UIColor, linespace: CGFloat, xOffset x: CGFloat, yOffset y: CGFloat) {
        
        let temp = text
        self.font = font
        self.textColor = textColor
        self.xOffset = x
        self.yOffset = y
        self.contentString = text
        
        context.textMatrix = CGAffineTransform.identity
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        
        let attributedStr = StringAttributes.defaultAttribute(text, font: font, antTextColor: textColor, linespace: linespace, lineBreakMode: .byCharWrapping)
        let attributedString = self.highlightTextRange(range: range, coloredString: attributedStr)
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        if temp == text {
            self.drawFramesetter(framesetter: framesetter, attributedString: attributedString, textRange: CFRangeMake(0, (text as NSString).length), inRect: rect, context: context)
            context.textMatrix = CGAffineTransform.identity
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
        }
    }

    
    func setText(text: String, withContext context: CGContext, contentSize size: CGSize, backgroundColor: UIColor, font: UIFont, textColor: UIColor, linespace: CGFloat, xOffset x: CGFloat, yOffset y: CGFloat) {
        
        let temp = text
        self.font = font
        self.textColor = textColor
        self.xOffset = x
        self.yOffset = y
        self.contentString = text
        
        context.textMatrix = CGAffineTransform.identity
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let attributedStr = StringAttributes.defaultAttribute(text, font: font, antTextColor: textColor, linespace: linespace, lineBreakMode: .byCharWrapping)
        
        let attributedString = self.highlightText(coloredString: attributedStr)
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        if temp == text {
            self.drawFramesetter(framesetter: framesetter, attributedString: attributedString, textRange: CFRangeMake(0, (text as NSString).length), inRect: rect, context: context)
            context.textMatrix = CGAffineTransform.identity
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
        }
    }
    
    
    func drawFramesetter(framesetter: CTFramesetter, attributedString: NSAttributedString, textRange: CFRange, inRect: CGRect, context: CGContext) {
        
        let path = CGMutablePath()
        path.addRect(inRect)
        let frame = CTFramesetterCreateFrame(framesetter, textRange, path, nil)
        let ContentHeight = inRect.size.height
        let lines = CTFrameGetLines(frame)
        let numberOfLines = CFArrayGetCount(lines)
        
        var lineOrigins = Array<CGPoint>(repeating: CGPoint.zero, count: numberOfLines)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), &lineOrigins)

        for lineIndex in 0..<numberOfLines {
            
            let lineOrigin: CGPoint = lineOrigins[lineIndex]
            let line: CTLine =  unsafeBitCast(CFArrayGetValueAtIndex(lines, lineIndex), to: CTLine.self)
            var descent = CGFloat(0.0)
            var ascent  = CGFloat(0.0)
            var lineLeading = CGFloat(0.0)
            
            CTLineGetTypographicBounds(line, &ascent, &descent, &lineLeading)
            let penOffset = CGFloat(CTLineGetPenOffsetForFlush(line, CGFloat(NSTextAlignment.left.rawValue), Double(inRect.size.width)))
            let y = lineOrigin.y - descent - self.font.descender
            
            if lineIndex == numberOfLines - 1 {
                var effectiveRange = CFRange(location: 0, length: 0)
                let stringAttrs: CFDictionary = CFAttributedStringGetAttributes(attributedString, 0, &effectiveRange)
                let truncationString: CFAttributedString = CFAttributedStringCreate(nil, "\u{2026}" as CFString!, stringAttrs)
                let truncationToken: CTLine = CTLineCreateWithAttributedString(truncationString)
                
                var rng: CFRange = CFRangeMake(CTLineGetStringRange(line).location, 0)
                rng.length = CFAttributedStringGetLength(attributedString) - rng.location
                
                let longString: CFAttributedString = CFAttributedStringCreateWithSubstring(nil, attributedString, rng)
                let longLine: CTLine = CTLineCreateWithAttributedString(longString)
                
                let showtruncated:CTLine!
                if let truncated: CTLine = CTLineCreateTruncatedLine(longLine, Double(inRect.size.width), CTLineTruncationType.end, truncationToken) {
                    showtruncated = truncated
                } else {
                    showtruncated = line
                }
                context.textPosition =  CGPoint(x: penOffset + self.xOffset, y: y - self.yOffset)
                CTLineDraw(showtruncated, context)
            } else {
                context.textPosition =  CGPoint(x: penOffset + self.xOffset, y: y - self.yOffset)
                CTLineDraw(line, context)
            }
            
            let runs: CFArray = CTLineGetGlyphRuns(line)
            for j in 0..<CFArrayGetCount(runs) {
                var runAscent:    CGFloat = 0.0
                var runDescent:   CGFloat = 0.0
                var lineLeading1: CGFloat = 0.0
                
                let run: CTRun = unsafeBitCast(CFArrayGetValueAtIndex(runs, j), to: CTRun.self)
                let attributes: NSDictionary = CTRunGetAttributes(run)
                
                if attributes.value(forKey: NSForegroundColorAttributeName ) as! CGColor != self.textColor.cgColor {
                    
                    let range: CFRange = CTRunGetStringRange(run)
                    let offset = CTLineGetOffsetForStringIndex(line, range.location, nil)
                    
                    var runRect = CGRect.zero
                    runRect.size.width = CGFloat(CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, &lineLeading1))
                    runRect.size.height = self.font.lineHeight
                    runRect.origin.x = lineOrigin.x + offset + self.xOffset
                    runRect.origin.y = lineOrigin.y
                    runRect.origin.y -= descent + self.yOffset
                    
                    var transform: CGAffineTransform = CGAffineTransform(translationX: 0, y: ContentHeight)
                    transform = transform.scaledBy(x: 1.0, y: -1.0)
                    
                    let flipRect: CGRect = runRect.applying(transform)
                    let nRange: NSRange = NSMakeRange(range.location, range.length)
                    self.framesDict[NSStringFromRange(nRange)] = NSValue(cgRect: flipRect)
                    
                    for rangeString in self.ranges {
                        let range: NSRange = NSRangeFromString(rangeString)
                        if NSLocationInRange(nRange.location, range) {
                            if var array = self.relationDict[rangeString] {
                                array.append(NSStringFromCGRect(flipRect))
                                self.relationDict[rangeString] = array
                            } else {
                                self.relationDict[rangeString] = [NSStringFromCGRect(flipRect)]
                            }
                        }
                    }
                }
            }
        }
    }
    
}
