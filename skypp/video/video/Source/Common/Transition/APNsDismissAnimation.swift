//
//  APNsDismissAnimation.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/10/13.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit

class APNsDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        {
            let containerView = transitionContext.containerView
            fromVC.view.subviews[0].removeFromSuperview()
            containerView.addSubview(toVC.view)
            containerView.sendSubview(toBack: toVC.view)
            toVC.view.alpha = 1
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                           animations: { () -> Void in
                            fromVC.view.layer.setAffineTransform(CGAffineTransform.identity.translatedBy(x: kScreenWidth,y: 0))
                }, completion: { (finished) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    fromVC.view.alpha = 0
                    fromVC.view.layer.setAffineTransform(CGAffineTransform.identity)
            })
        }
    }
}
