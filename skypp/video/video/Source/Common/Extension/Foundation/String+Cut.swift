//
//  String+Cut.swift
//  Ironhide
//
//  Created by Chris Huang on 16/10/19.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation


extension String {
    
    
    func substringFromIndex(_ from: Int) -> String{
        
        
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return self.substring(from: fromIndex)

    }
    
    
    func substringToIndex(_ to: Int) -> String{
        
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return self.substring(to: toIndex)
    }
    
    func substringByNSRange(_ nsRange:NSRange) -> String{
        
        let fromIndex = self.index(self.startIndex, offsetBy: nsRange.location)
        let toIndex = self.index(self.startIndex, offsetBy: nsRange.location+nsRange.length)
        let range = fromIndex ..< toIndex
        return self.substring(with: range)
        
    }
    
    
    func substringToEndDistanceBy(_ distance: Int) -> String{
        
        
        let toIndex = self.index(self.endIndex, offsetBy: -distance)
        return self.substring(to: toIndex)

    }
}
