//
//  CircleFixedQueue.swift
//  Ironhide
//
//  Created by Chris Huang on 16/11/13.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation

enum EnqueueDirection: Int {
    case Head = 1
    case Tail = -1
}


class TwoWayFixedQueue<T> : NSObject{
    
    var items = [T]()
    var fixedCount = 0
    
    var head = 0
    var tail = -1
    
    init(_ count: Int) {
        self.fixedCount = count
    }
    
    func enqueue(_ value: T, direction: EnqueueDirection = .Tail) -> T? {
        
        var result:T? = nil
        if items.count < fixedCount {
            self.items.append(value)
            self.tail += 1
        }
        else{
            if direction == .Tail {
                self.head = (self.head + 1) % self.fixedCount
                self.tail = (self.tail + 1) % self.fixedCount
                result = self.items[self.tail]
                self.items[self.tail] = value
            }
            else{
                self.head = (self.head - 1 + self.fixedCount) % self.fixedCount
                self.tail = (self.tail - 1 + self.fixedCount) % self.fixedCount
                result = self.items[self.head]
                self.items[self.head] = value
            }
        }
        
        return result
    }
    
    
    func sortedItems() -> [T] {
        
        var newItems = [T]()
        for i in 0..<self.fixedCount {
            let index = (self.head + i ) % self.fixedCount
            newItems.append(self.items[index])
        }
        
        return newItems
    }

}
