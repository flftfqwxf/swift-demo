//
//  ViewController + EmptyView + ReloadView.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/13.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import DZNEmptyDataSet

var emptyDataSetObjectPointer = "emptyDataSetObjectPointer"
extension UIViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    @discardableResult
    public func addScrollViewLoading(scrollView: UIScrollView) -> UIScrollView {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.emptyDataSetObject = activityView
        scrollView.emptyDataSetDelegate = self
        scrollView.emptyDataSetSource = self
        scrollView.reloadEmptyDataSet()
        return scrollView
    }
    
    public func hiddenScrollViewEmptyDataObject(scrollView: UIScrollView) {
        self.emptyDataSetObject = nil
        scrollView.emptyDataSetDelegate = self
        scrollView.emptyDataSetSource = self
        scrollView.reloadEmptyDataSet()
    }
    
    public func addScrollViewEmptyDataObject(scrollView: UIScrollView, customObject: AnyObject?) {
        if let image = customObject as? UIImage {
            self.emptyDataSetObject = image
        } else if let view = customObject as? UIView {
            self.emptyDataSetObject = view
        } else {
            self.emptyDataSetObject = nil
        }
        scrollView.emptyDataSetDelegate = self
        scrollView.emptyDataSetSource = self
        scrollView.reloadEmptyDataSet()
        if let tableView = scrollView as? UITableView {
            tableView.reloadData()
        }
        if let collectionView = scrollView as? UICollectionView {
            collectionView.reloadData()
        }
    }
    
    // 代理方法
    public func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        if let view = self.emptyDataSetObject as? UIView {
            return view
        } else if let image = self.emptyDataSetObject as? UIImage {
            return UIImageView(image: image)
        } else {
            return UIView()
        }
    }
    
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        if scrollView is UITableView {
            if let headerView  = (scrollView as? UITableView)?.tableHeaderView {
                return headerView.frame.size.height / 2.0
            }
        }
        return 0
    }
    
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return self.emptyDataSetObject != nil
    }
    
    
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
    var emptyDataSetObject: AnyObject? {
        get {
            return objc_getAssociatedObject(self, &emptyDataSetObjectPointer) as AnyObject?
        }
        set {
            objc_setAssociatedObject(self, &emptyDataSetObjectPointer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        if let view = self.emptyDataSetObject as? UIActivityIndicatorView {
            view.startAnimating()
        }
    }
}


var kLoadingViewControllerKey = "kLoadingViewControllerKey"
extension UIViewController {
    
    private var loadingView: UIActivityIndicatorView {
        get {
            if let activityView = objc_getAssociatedObject(self, &kLoadingViewControllerKey) as? UIActivityIndicatorView {
                return activityView
            } else {
                let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                activityView.center = self.view.center
                self.view.addSubview(activityView)
                objc_setAssociatedObject(self, &kLoadingViewControllerKey, activityView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                return activityView
            }
        }
    }
    
    func showLoadingView() {
        self.view.bringSubview(toFront: self.loadingView)
        self.loadingView.startAnimating()
    }
    
    func dismissLoadingView() {
        self.loadingView.stopAnimating()
    }
}
