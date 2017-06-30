//
//  UIViewController+Filter.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/11/14.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit

var kViewControllerFilterKey = "kViewControllerFilterKey"
var kViewControllerFilterRefreshKey = "kViewControllerFilterRefreshKey"
var kViewControllerFilterIsVisibleKey = "kViewControllerFilterIsVisibleKey"

protocol FilterProtocol {
    var filterValue: Int { get set }
    func filterChanged(value: Int)
}

// Mark: TODO next time
extension FilterProtocol {
}

// 筛选响应
class FilterResponseViewController: UIViewController {
}

extension UIViewController {
    
    var isVisible: Bool {
        get {
            return (objc_getAssociatedObject(self, &kViewControllerFilterIsVisibleKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &kViewControllerFilterIsVisibleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    
    var filterValue: Int {
        get {
            return (objc_getAssociatedObject(self, &kViewControllerFilterKey) as? Int) ?? 0
        }
        set {
            let valueChanged = newValue != self.filterValue
            objc_setAssociatedObject(self, &kViewControllerFilterKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            if valueChanged{
                if self.isVisible == true {
                    self.needFilterRefresh = false
                    self.filterChanged(value: newValue)
                } else {
                    self.needFilterRefresh = true
                }
            }
        }
    }
    
    var needFilterRefresh: Bool {
        get {
            return (objc_getAssociatedObject(self, &kViewControllerFilterRefreshKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &kViewControllerFilterRefreshKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func filterContainerTransitionEnd() {
        if self.needFilterRefresh {
            self.filterChanged(value: self.filterValue)
        }
        self.needFilterRefresh = false
    }
    
    func filterChanged(value: Int) {
        
    }
}
