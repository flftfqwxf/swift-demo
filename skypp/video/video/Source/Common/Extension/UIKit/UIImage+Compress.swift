//
//  UIImage+Compress.swift
//  Ironhide
//
//  Created by Chris Huang on 16/11/1.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func compressToSize(_ size: CGFloat) -> UIImage? {    // 单位: K
        
        //图片的压缩比和压缩后的大小是线性关系(如果从quality从1开始就不是线性关系)
        if let maxImageData = UIImageJPEGRepresentation(self, 0.99) {
            let specificSize = size * 1024.0
            if maxImageData.count > 0 {
                let quality = specificSize/CGFloat((maxImageData.count))
                
                if quality < 1.0 {
                    if let specificImageData = UIImageJPEGRepresentation(self, quality) {
                        return UIImage(data: specificImageData)
                    }
                }
            }
        }
        
        return self
    }

    
}
