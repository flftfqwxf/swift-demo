//
//  DismissAnimator.swift
//  video
//
//  Created by leixianhua on 2017/7/6.
//  Copyright © 2017年 leixianhua. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: .to)
        let fromViewController = transitionContext.viewController(forKey: .from)

        let fromView = transitionContext.view(forKey: .from) != nil ? transitionContext.view(forKey: .from)! :transitionContext.viewController(forKey: .from)!.view!
        let toView = transitionContext.view(forKey: .to) != nil ? transitionContext.view(forKey: .to) :transitionContext.viewController(forKey: .to)!.view
        let containerView = transitionContext.containerView
        
        fromView.frame = transitionContext.initialFrame(for: fromViewController!)
        
        containerView.addSubview(fromView)
//        print(containerView.subviews)
        let dismissView = containerView.viewWithTag(1000)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromView.alpha = 0
            dismissView?.alpha = 0
            let frame = transitionContext.initialFrame(for: toViewController!)
            print(frame)
            let frame2 = transitionContext.initialFrame(for: fromViewController!)
print(frame2)
            fromView.frame = CGRect(x: 0, y: -500, width: fromView.frame.width, height: fromView.frame.height)

        }) { (finshed :Bool) in
            let wasCanceled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCanceled)
        }
    }
}
