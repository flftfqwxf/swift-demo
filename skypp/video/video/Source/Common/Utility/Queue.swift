//
//  Queue.swift
//  Ironhide
//
//  Created by Chris Huang on 16/11/13.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation

class _QueueItem<T> {
    
    let value: T!
    var next: _QueueItem?
    
    init(_ newvalue: T?) {
        self.value = newvalue
    }
    
}

public class Queue<T> {
    
    
    var _front: _QueueItem<T>
    var _back: _QueueItem<T>
    
    public init () {
        // Insert dummy item. Will disappear when the first item is added.
        _back = _QueueItem(nil)
        _front = _back
    }
    
    /// Add a new item to the back of the queue.
    public func enqueue (_ value: T) {
        _back.next = _QueueItem(value)
        _back = _back.next!
    }
    
    /// Return and remove the item at the front of the queue.
    public func dequeue () -> T? {
        if let newhead = _front.next {
            _front = newhead
            return newhead.value
        } else {
            return nil
        }
    }
    
    public func isEmpty() -> Bool {
        return _front === _back
    }
    
    
}
