//
//  SearchHistoryCacheManager.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/8/30.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import RealmSwift

final class SearchHistoryItem: Object {
    
    dynamic var identity: String = ""
    dynamic var key: String = ""
    dynamic var category: String = ""
    dynamic var timestamp: Double = 0.0
    
    required convenience init(key: String, category: String) {
        self.init()
        self.key = key
        self.category = category
        self.identity = key+category
        self.timestamp = NSDate().timeIntervalSince1970
    }
    
    override class func primaryKey() -> String {
        return "identity"
    }
    
    override class func indexedProperties() -> [String] {
        return ["identity"]
    }
}

class SearchHistoryCacheManager: RealmBaseManager<SearchHistoryItem> {
    
    
    class var sharedInstance : SearchHistoryCacheManager {
        struct Static {
            static let instance : SearchHistoryCacheManager = SearchHistoryCacheManager()
        }
        return Static.instance
    }

    private var _datas: [SearchHistoryItem]!
    override var datas: [SearchHistoryItem] {
        set{
            _datas = newValue
        }
        get{
            if _datas == nil {
                self.synchronizeDatas()
            }
            return _datas
        }
    }
    
    func synchronizeDatas() {
        if let realmObject = realm {
            self.datas = realmObject.allObjects(fromClass: SearchHistoryItem.self, sortedBy: "timestamp", ascending: false)
        } else {
            self.datas = [SearchHistoryItem]()
        }
    }
    
    func allSearchKey(_ category: String) -> [SearchHistoryItem] {
       
        return self.datas.filter { $0.category == category }
    }

    @discardableResult
    func addSearchItem(_ key: String, category: String) -> [SearchHistoryItem] {
        let item = SearchHistoryItem(key: key, category: category)
        self.addOrUpdateData(data: [item])
        self.synchronizeDatas()
        if self.datas.count > 10 {
            var array = [SearchHistoryItem]()
            for i in 10..<self.datas.count {
                array.append(self.datas[i])
            }
           self.deleteData(data: array)
           self.synchronizeDatas()
        }
        return self.datas
    }
  
    
    @discardableResult
    func removeSearchItem(_ key: String, category: String) -> [SearchHistoryItem] {
        let filterArray = self.datas.filter {$0.key == key && $0.category == category}
        if let item = filterArray.first {
            self.deleteData(data: [item])
            self.synchronizeDatas()
        }
        return self.datas
    }
    
    @discardableResult
    func removeAllSearchKey(_ category: String) -> [SearchHistoryItem] {
        
        let filterArray = self.datas.filter { $0.category == category }
        self.deleteData(data: filterArray)
        self.synchronizeDatas()
        return [SearchHistoryItem]()
    }

}

