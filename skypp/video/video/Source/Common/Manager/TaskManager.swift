//
//  TaskManager.swift
//  Ironhide
//
//  Created by Chris Huang on 16/9/10.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation

typealias Task = (() -> Void)

class TaskManager {
    
    var tasks:[String:Task] = [String:Task]()
    
    class var shareInstance: TaskManager {
        
        struct Static {
            static let instance = TaskManager()
        }
        
        return Static.instance
    }
    
    
    func addTask(_ key: String, task: @escaping Task) {
        
        self.tasks[key] = task;
        
    }
    
    func popTask(_ key: String) -> Task? {
        
        let task = self.tasks.removeValue(forKey: key)
        return task
    }
    
    func removeTask(_ key: String) {
        
        self.tasks.removeValue(forKey: key)
    }
    
}
