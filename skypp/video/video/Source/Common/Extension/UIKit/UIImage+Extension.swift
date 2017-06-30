//
//  UIImage+Extension.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/2.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
     根据颜色生成图片     
     */
    class func imageWithColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height:  k1px * 2)) -> UIImage {
        let rect:CGRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor);
        context.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    /**
     将图片压缩到指定大小
     */
    class func resizeData(_ source: UIImage, maxSize: NSInteger = 128) -> NSData? {
        let size = CGSize(width: source.size.width, height:  source.size.height)
        UIGraphicsBeginImageContext(size);
        source.drawAsPattern(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            if let imageData = UIImageJPEGRepresentation(image, 1.0) {
                let sizeOriginKB:Int = imageData.count / 1024
                if (sizeOriginKB > maxSize) {
                    let rate:CGFloat = CGFloat(maxSize) / CGFloat(sizeOriginKB)
                    return UIImageJPEGRepresentation(image, rate) as NSData?
                }
                return imageData as NSData?
            }
        }
        return nil
    }
    
    func resizeData(_ maxSize: NSInteger = 128) -> NSData? {
        let size = CGSize(width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContext(size);
        self.drawAsPattern(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            if let imageData = UIImageJPEGRepresentation(image, 1.0) {
                let sizeOriginKB:Int = imageData.count / 1024
                if (sizeOriginKB > maxSize) {
                    let rate:CGFloat = CGFloat(maxSize) / CGFloat(sizeOriginKB)
                    return UIImageJPEGRepresentation(image, rate) as NSData?
                }
                return imageData as NSData?
            }
        }
        return nil
    }
    
    func resizeCellImage(size: CGSize = CGSize(width: 120, height: 90)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    func colorizeImageWithColor(_ color: UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        if let context: CGContext = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -area.size.height)
            context.saveGState()
            context.clip(to: area, mask: cgImage)
            color.set()
            context.fill(area)
            context.restoreGState()
            context.setBlendMode(CGBlendMode.multiply)
            context.draw(cgImage, in: area)
            
            let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return colorizedImage
        }
        
        return nil
    }
}
