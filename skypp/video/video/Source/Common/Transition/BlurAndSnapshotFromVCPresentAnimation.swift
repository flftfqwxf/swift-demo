//
//  ScaleAndsnapshotFromVCPresentAnimation.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/2.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit

class BlurAndSnapshotFromVCPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) {
        
            fromVC.view.clipsToBounds = true
            let containerView = transitionContext.containerView
            containerView.backgroundColor = kColorNavigationBackground
            toVC.view.backgroundColor = UIColor.clear
            
            if let fromVCSnapshot = fromVC.view.snapshotView(afterScreenUpdates: false) {
                fromVC.view.removeFromSuperview()
                containerView.addSubview(fromVCSnapshot)
                fromVCSnapshot.alpha = 1
                
                let effectview = UIToolbar()
                effectview.barStyle = UIBarStyle.blackTranslucent
                effectview.frame = fromVCSnapshot.bounds
                containerView.addSubview(effectview)
                effectview.alpha = 0
                
                containerView.addSubview(toVC.view)
                
                toVC.view.layer.setAffineTransform(CGAffineTransform.identity.translatedBy(x: 0, y: 0).scaledBy(x: 0.3, y: 0.3))
                
                UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                    delay: 0.0,
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0.0,
                    options: UIViewAnimationOptions.curveLinear,
                    animations: { () -> Void in
                        toVC.view.layer.setAffineTransform(CGAffineTransform.identity)
                        fromVCSnapshot.layer.setAffineTransform(CGAffineTransform.identity.scaledBy(x: 0.94, y: 0.92))
                        fromVCSnapshot.alpha = 0.6
                        effectview.alpha = 1
                }, completion: { (finished) -> Void in
                    toVC.view.insertSubview(fromVCSnapshot, at: 0)
                    toVC.view.insertSubview(effectview, at: 1)
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
    }
    
}
