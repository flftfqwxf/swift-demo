//
//  UIView+Xib.swift
//  Ironhide
//
//  Created by Chris Huang on 16/9/1.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    class func viewFromXib() -> UIView? {
        
        var result: UIView? = nil
        
        if let className = NSStringFromClass(self).components(separatedBy: ".").last {
            result = UINib(
                nibName: className,
                bundle: Bundle.main
                ).instantiate(withOwner: nil, options: nil)[0] as? UIView
        }

        return result
    }
    
    
}
