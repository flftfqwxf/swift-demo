//
//  Realm+Extension.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/8.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    func allObjects<T: Object>(fromClass cls: T.Type) -> [T] {
        var array = [T]()
        let result  = objects(cls)
        result.forEach { (obj) -> () in
            array.append(obj)
        }
        return array
    }
    
    func allObjects<T: Object>(fromClass cls: T.Type, sortedBy property: String, ascending: Bool) -> [T] {
        var array = [T]()
        let result  = objects(cls).sorted(byProperty: property, ascending: ascending)
        result.forEach { (obj) -> () in
            array.append(obj)
        }
        
        return array
    }
    
    func allObjects<T: Object>(fromClass cls: T.Type, predicate: NSPredicate) -> [T] {
        var array = [T]()
        let result  = objects(cls).filter(predicate)
        result.forEach { (obj) -> () in
            array.append(obj)
        }
        return array
    }
}
