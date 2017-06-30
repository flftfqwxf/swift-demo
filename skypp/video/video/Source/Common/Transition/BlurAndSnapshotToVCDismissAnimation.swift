//
//  BlurAndSnapshotToVCDismissAnimation.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/2.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit

class BlurAndSnapshotToVCDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) {
        
            fromVC.view.subviews[0].removeFromSuperview()
            
            let containerView = transitionContext.containerView
            containerView.backgroundColor = kColorNavigationBackground
            containerView.addSubview(toVC.view)
            containerView.sendSubview(toBack: toVC.view)
            
            toVC.view.layer.setAffineTransform(CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.92))
            toVC.view.alpha = 0.6
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                animations: { () -> Void in
                toVC.view.layer.setAffineTransform(CGAffineTransform.identity)
                toVC.view.alpha = 1
                fromVC.view.alpha = 0
                fromVC.view.layer.setAffineTransform(CGAffineTransform.identity.scaledBy(x: 1.3, y: 1.3))
            }, completion: { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                fromVC.view.layer.setAffineTransform(CGAffineTransform.identity)
                fromVC.view.alpha = 1
                fromVC.view.subviews[0].removeFromSuperview()
            })
        }
    }
}
