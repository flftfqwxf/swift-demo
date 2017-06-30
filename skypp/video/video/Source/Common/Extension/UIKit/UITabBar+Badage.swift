//
//  UITabBar + BadageView.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/11/25.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit

let TabbarItemNums = 3

extension UITabBar {

    func showBadgeOnItemIndex(index: Int) {
        
        self.removeBadgeOnItemIndex(index: NSNumber(value: index))
        
        let badgeView = UIView()
        badgeView.tag = 999 + index
        badgeView.layer.cornerRadius = 5.0
        badgeView.backgroundColor = UIColor.red
        
        let tabFrame = self.frame
        let percentX: CGFloat = (CGFloat(index) + 0.6) / CGFloat(TabbarItemNums)
        let x = ceil(percentX * tabFrame.size.width)
        let y = ceil(0.1 * tabFrame.size.height)
        badgeView.frame = CGRect(x: x, y: y, width: 10.0, height: 10.0)
        badgeView.clipsToBounds = true
        self.addSubview(badgeView)
        badgeView.isHidden = true
        self.annimationShow(view: badgeView)
    }
    
    
    func hideBadgeOnItemIndex(index: Int) {
        self.perform(#selector(removeBadgeOnItemIndex(index:)), with: NSNumber(value: index), afterDelay: 0.0)
    }
    
    func removeBadgeOnItemIndex(index: NSNumber) {
        for subView in self.subviews {
            if subView.tag == 999 + index.intValue {
                self.annimationRemove(view: subView)
            }
        }
    }
    
    func annimationRemove(view: UIView) {
        
        UIView.animate(withDuration: 0.15, animations: {
            view.layer.setAffineTransform(CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5))
        }) { (finsh) in
            UIView.animate(withDuration: 0.15, animations: {
                view.layer.setAffineTransform(CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5))
            }, completion: { (finsh) in
                    view.removeFromSuperview()
            })
        }
    }
    
    func annimationShow(view: UIView) {
        
        view.isHidden = false
        UIView.animate(withDuration: 0.15, animations: {
            view.layer.setAffineTransform(CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5))
        }) { (finsh) in
            UIView.animate(withDuration: 0.15, animations: {
                view.layer.setAffineTransform(CGAffineTransform.identity)
            })
        }
    }
}
