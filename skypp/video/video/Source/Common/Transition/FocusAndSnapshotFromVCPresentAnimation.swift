//
//  FocusAndSnapshotFromVCPresentAnimation.swift
//  HrmesTV
//
//  Created by xuzhi on 16/3/25.
//  Copyright © 2016年 Hrmes. All rights reserved.
//

import UIKit

class FocusAndSnapshotFromVCPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transformDistance = CGFloat(480)

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
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
                fromVCSnapshot.alpha = 1
                let shdowView =  UIView(frame: fromVCSnapshot.bounds)
                shdowView.backgroundColor = UIColor.black
                fromVCSnapshot.addSubview(shdowView)
                shdowView.alpha = 0
                
                containerView.addSubview(toVC.view)
                toVC.view.layer.setAffineTransform(CGAffineTransform.identity.translatedBy(x: 0, y: self.transformDistance))
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
                        shdowView.alpha = 0.33
                    }, completion: { (finished) -> Void in
                        toVC.view.insertSubview(fromVCSnapshot, at: 0)
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
    }
}
