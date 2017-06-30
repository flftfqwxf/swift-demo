//
//  FocusAndSnapshotToVCDismissAnimation.swift
//  HrmesTV
//
//  Created by xuzhi on 16/3/25.
//  Copyright © 2016年 Hrmes. All rights reserved.
//

import UIKit

class FocusAndSnapshotToVCDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transformDistance = CGFloat(480)
    
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
            let shdowView =  UIView(frame: toVC.view.bounds)
            shdowView.backgroundColor = UIColor.black
            toVC.view.addSubview(shdowView)
            shdowView.alpha = 0.33

            UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                animations: { () -> Void in
                    fromVC.view.layer.setAffineTransform(CGAffineTransform.identity.translatedBy(x: 0, y: self.transformDistance))
                    shdowView.alpha = 0
                }, completion: { (finished) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    shdowView.removeFromSuperview()
                    fromVC.view.alpha = 0
                    fromVC.view.layer.setAffineTransform(CGAffineTransform.identity)
            })
        }
    }
}
