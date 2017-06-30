//
//  UIButton+Animation.swift
//  Ironhide
//
//  Created by Chris Huang on 16/9/23.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func expandAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (success) in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            }) { (success) in }
        }
        
    }
    
}
