//
//  APNsPresentAnimation.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/10/13.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit
import Foundation

class APNsPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        {
            
            let containerView = transitionContext.containerView
            fromVC.view.clipsToBounds = true
            toVC.view.backgroundColor = UIColor.clear
            
            if let fromVCSnapshot = fromVC.view.snapshotView(afterScreenUpdates: false) {
                fromVC.view.removeFromSuperview()
                containerView.addSubview(fromVCSnapshot)
                containerView.addSubview(toVC.view)
                toVC.view.layer.setAffineTransform(CGAffineTransform.identity.translatedBy(x: kScreenWidth, y: 0))
                toVC.view.alpha = 0
                UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                                           delay: 0.0,
                                           usingSpringWithDamping: 1.0,
                                           initialSpringVelocity: 0.0,
                                           options: UIViewAnimationOptions.curveLinear,
                                           animations: { () -> Void in
                                            toVC.view.layer.setAffineTransform(CGAffineTransform.identity)
                                            toVC.view.alpha = 1
                                            fromVCSnapshot.alpha = 1
                    }, completion: { (finished) -> Void in
                        toVC.view.insertSubview(fromVCSnapshot, at: 0)
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
    }

}
