//
//  Refresh+UITableView.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/8/9.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit
import MJRefresh

private var loadMoreBlockKey = 100
private var refreshingBlockKey = 101

typealias RefreshBlock = () -> Void

extension UITableView {
    
    private class BlockObject {
        var block: RefreshBlock?
    }
    
    private func configHeader(block: @escaping RefreshBlock) {
        let header = MJRefreshGifHeader(refreshingBlock: block)
        let imageArray = [I.Image.fly1!, I.Image.fly3!, I.Image.fly2!]
        header?.setImages(imageArray, duration:1.5, for: MJRefreshState.idle)
        header?.setImages(imageArray, duration:1.5, for: MJRefreshState.pulling)
        header?.setImages(imageArray, duration:1.5, for: MJRefreshState.refreshing)
        header?.setTitle("          下拉可以更新", for:.idle)
        header?.setTitle("          放开立即更新", for:.pulling)
        header?.setTitle("          正在更新中...", for:.refreshing)
        header?.stateLabel.textColor = kThemeColorDeepGray
        header?.labelLeftInset = -30
        header?.lastUpdatedTimeLabel?.isHidden = true
        header?.stateLabel.font = UIFont.systemFont(ofSize: 13.0)
        self.mj_header = header
    }
    
    @discardableResult
    func headerWithRefreshingBlock(block: @escaping RefreshBlock) -> UITableView {
        self.refreshBlock = block
        self.configHeader(block: block)
        return self
    }
    
    
    private func configFooter(block: @escaping RefreshBlock) {
        let footer = MJRefreshAutoGifFooter(refreshingBlock: block)
        let imageArray = [I.Image.load_more_1!,
                          I.Image.load_more_2!,
                          I.Image.load_more_3!,
                          I.Image.load_more_4!,
                          I.Image.load_more_5!,
                          I.Image.load_more_6!,
                          I.Image.load_more_7!,
                          I.Image.load_more_8!,
                          I.Image.load_more_9!,
                          I.Image.load_more_10!,
                          I.Image.load_more_11!,
                          I.Image.load_more_12!]
        footer?.setImages(imageArray, duration: 1.0 , for: MJRefreshState.refreshing)
        footer?.setTitle("", for:.idle)
        footer?.stateLabel.textColor = kThemeColorDeepGray
        footer?.stateLabel.font = UIFont.systemFont(ofSize: 13.0)
        footer?.isRefreshingTitleHidden = true
        footer?.setTitle("－ 没有更多了 －", for:.noMoreData)
        footer?.isAutomaticallyHidden = true
        self.mj_footer = footer
    }
    
    @discardableResult
    func footerWithrefreshingBlock(block: @escaping RefreshBlock) -> UITableView{
        self.loadMoreBlock = block
        self.configFooter(block: block)
        return self
    }
    
    func headerBeginRefreshing() {
        self.mj_header?.beginRefreshing()
    }
    
    func headerEndRefreshing() {
        self.mj_footer?.resetNoMoreData()
        self.mj_header?.endRefreshing()
    }

    func headerEndRefreshWith(hasMore: Bool, currentIsEmpty: Bool = true) {
        if self.mj_header != nil {
           self.mj_header.endRefreshing()
        }
        if hasMore {
            if self.mj_footer == nil && self.refreshBlock != nil {
                self.configFooter(block: self.loadMoreBlock!)
            }
            self.mj_footer?.resetNoMoreData()
        } else {
            if currentIsEmpty {
                self.mj_footer = nil
            } else {
                self.mj_footer?.endRefreshingWithNoMoreData()
            }
        }
    }
    
    func footerBeginRefresh() {
        self.mj_footer?.beginRefreshing()
    }
    
    func footerEndRefresh() {
        self.mj_footer?.endRefreshing()
    }
    
    func endRefreshingWithNoMoreData() {
        self.mj_footer?.endRefreshingWithNoMoreData()
    }

    func footerEndRefreshWith(hasMore: Bool) {
        if hasMore {
            self.mj_footer?.endRefreshing()
        } else {
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
    }

    func resetNoMoreData() {
        self.mj_footer?.resetNoMoreData()
    }
    
    private var refreshBlock: (() -> Void)? {
        get {
            let blockObj = objc_getAssociatedObject(self, &refreshingBlockKey) as? BlockObject
            if let obj = blockObj {
                return obj.block
            } else {
                return nil
            }
        }
        set {
            let blockObj = BlockObject()
            blockObj.block = newValue
            objc_setAssociatedObject(self, &refreshingBlockKey, blockObj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var loadMoreBlock: (() -> Void)? {
        get {
            let blockObj = objc_getAssociatedObject(self, &loadMoreBlockKey) as? BlockObject
            if let obj = blockObj {
                return obj.block
            } else {
                return nil
            }
        }
        set {
            let blockObj = BlockObject()
            blockObj.block = newValue
            objc_setAssociatedObject(self, &loadMoreBlockKey, blockObj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

