//
//  UIImage+Size.swift
//  Ironhide
//
//  Created by Chris Huang on 16/10/26.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

extension UIImage {
    
    func fittingSize(_ width:CGFloat) -> CGSize {
        
        if width > 0 && self.size.width > width {
            let height = (self.size.height * width) / self.size.width
            
            return CGSize(width: width, height: height)
 
        }
        
        return self.size
        
    }
    
}
