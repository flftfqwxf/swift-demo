//
//  Animator.swift
//  video
//
//  Created by leixianhua on 2017/7/5.
//  Copyright © 2017年 leixianhua. All rights reserved.
//

import UIKit

class TopAnimator : NSObject,UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
//        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinator.view(forKey:))) {
//           let fromView = transitionContext.view(forKey: .from)
            let toView = transitionContext.view(forKey: .to)
//        }
        
        toView?.frame = UIScreen.main.bounds
        toView?.alpha = 0
        containerView.addSubview(toView!)
        UIView.animate(withDuration: 2.0, animations: { 
            toView!.alpha = 1
        }) { (finished: Bool) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}
