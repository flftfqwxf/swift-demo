//
//  DataBaseManager.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/6.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import RealmSwift

class RealmBaseManager<T: Object> {
    func allObjects(realm: Realm) -> [T] {
        var array = [T]()
        let result  = realm.objects(T.self)
        for i in 0..<result.count {
            array.append(result[i])
        }
        return array
    }
    
    func allObjects<T: Object>(realm: Realm, sortedBy property: String, ascending: Bool) -> [T] {
        var array = [T]()
        let result  = realm.objects(T.self).sorted(byProperty: property, ascending: ascending)
        for i in 0..<result.count {
            array.append(result[i])
        }
        return array
    }
    
    func allObjects<T: Object>(realm: Realm, predicate: NSPredicate) -> [T] {
        var array = [T]()
        let result  = realm.objects(T.self).filter(predicate)
        for i in 0..<result.count {
            array.append(result[i])
        }
        return array
    }
    
    var datas: [T] {
        get {
            if let realmObject = realm {
                return allObjects(realm: realmObject)
            }
            return [T]()
        }
    }
    
    var realm: Realm? {
        get {
            var config = Realm.Configuration()
            if let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first  {
                config.fileURL = URL(string: "\(documentPath)/realm.realm")
                config.readOnly = false
                do {
                   let realm = try Realm(configuration: config)
                   return realm
                } catch {
                    try! FileManager.default.removeItem(atPath: "\(documentPath)/realm.realm")
                    let realm = try! Realm(configuration: config)
                    return realm
                }
            }
            return nil
        }
    }
    
    func cleanCurrentTableData() {
        if let realmObject = realm {
            try! realmObject.write {
                realmObject.delete(realmObject.objects(T.self))
            }
        }
    }
    
    func addOrUpdateData(data: [T]) {
        if let realmObject = realm {
            try! realmObject.write {
                realmObject.add(data, update:true)
                
            }
        }
    }
    
    func deleteData(data:[T]) {
        if let realmObject = realm {
            try! realmObject.write {
                realmObject.delete(data)
            }
        }
    }

}

