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
        let toViewController = transitionContext.viewController(forKey: .to)
        let fromViewController = transitionContext.viewController(forKey: .from)!
//        var toView = transitionContext.viewController(forKey: .to)?.view

//        if transitionContext.responds(to: #selector(UIViewControllerTransitionCoordinator.view(forKey:))) {
            var fromView = transitionContext.view(forKey: .from) != nil ? transitionContext.view(forKey: .from) :transitionContext.viewController(forKey: .from)?.view
            var toView = transitionContext.view(forKey: .to) != nil ? transitionContext.view(forKey: .to) :transitionContext.viewController(forKey: .to)?.view

//        }
        
//        toView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        toView?.frame = CGRect(x: 0, y: -500, width: (fromView?.frame.width)!, height: 500)

        toView?.alpha = 0
        let transitionDuration = self.transitionDuration(using: transitionContext)

        let dimmingView = UIView(frame: CGRect.init(x: 300, y: 400, width: 100, height: 100))
        dimmingView.isUserInteractionEnabled = true
        dimmingView.backgroundColor = UIColor.black
        dimmingView.isOpaque = false
        
        
        
//        dimmingView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
//        dismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.taptst()))
//        dismissView.addTarget(self, action: #selector(self.taptst), for: .touchUpInside)
        
        
        containerView.addSubview(toViewController!.view)
toViewController?.view.insertSubview(dimmingView, at: 0)
        
        //toView?.insertSubview(dimmingView, at: 0)
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
            toView?.alpha = 1
            dimmingView.alpha = 0.5
            toView?.frame = transitionContext.finalFrame(for: toViewController!)
        }) { (finished: Bool) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
            dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TopAnimator.dimmingViewTapped(_:))))

        }
    }
    func dimmingViewTapped(_ sender: UITapGestureRecognizer) {
        print(55)
    }
    
    deinit {
        print("deinit")
    }
    
}
