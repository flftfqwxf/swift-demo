//
//  UIResponder+FirstResponder.swift
//  Ironhide
//
//  Created by Chris Huang on 16/10/21.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import UIKit

private var currentFirstResponder: UIResponder?

extension UIResponder {
    
    static func firstResponder() -> UIResponder? {
        currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder), to: nil, from: nil, for: nil)
        return currentFirstResponder
    }
    
    func findFirstResponder(_ sender: AnyObject) {
        currentFirstResponder = self
    }
    
}
