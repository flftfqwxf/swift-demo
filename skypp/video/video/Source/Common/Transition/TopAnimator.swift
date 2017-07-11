//
//  Animator.swift
//  video
//
//  Created by leixianhua on 2017/7/5.
//  Copyright © 2017年 leixianhua. All rights reserved.
//

import UIKit

class TopAnimator : NSObject,UIViewControllerAnimatedTransitioning {
    var toViewController : UIViewController?
    var dismissView :UIView!
    var toView :UIView!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let  containerView = transitionContext.containerView
         toViewController = transitionContext.viewController(forKey: .to)
        let fromViewController = transitionContext.viewController(forKey: .from)!

        var fromView = transitionContext.view(forKey: .from) != nil ? transitionContext.view(forKey: .from) :transitionContext.viewController(forKey: .from)?.view
         self.toView = transitionContext.view(forKey: .to) != nil ? transitionContext.view(forKey: .to) :transitionContext.viewController(forKey: .to)?.view

        let isPresenting = (toViewController?.presentingViewController == fromViewController)
        
        if isPresenting {
            present(toView: toView!, fromView: fromView!, transitionContext: transitionContext, containerView: containerView)

        } else {
            dismiss(fromView: fromView!, fromViewController: fromViewController, transitionContext: transitionContext, containerView: containerView)
        }
        
        
        
       
    }
    func present(toView:UIView,fromView:UIView,transitionContext:UIViewControllerContextTransitioning,containerView:UIView)  {
        let lastView = toView.subviews.last
        lastView?.tag = 1000
        lastView?.frame = CGRect(x: 0, y: -500, width: fromView.frame.width, height: 500)
        lastView?.alpha = 0
//        toView.alpha = 0
        let transitionDuration = self.transitionDuration(using: transitionContext)
        dismissView?.removeFromSuperview()
         dismissView = UIView(frame: containerView.bounds)
        dismissView.backgroundColor =  UIColor.black
        dismissView.alpha = 0
//        dismissView.tag = 1000
        dismissView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped)))
        //        dismissView.addTarget(self, action: #selector(self.taptst), for: .touchUpInside)
        toView.insertSubview(dismissView, at: 0)
//        containerView.addSubview(dismissView)
        containerView.addSubview(toView)
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
            lastView?.alpha = 1
            self.dismissView.alpha = 0.5
            lastView?.frame = transitionContext.finalFrame(for: self.toViewController!)
        }) { (finished: Bool) in
            let wasCancelled = transitionContext.transitionWasCancelled
            if wasCancelled {self.toView.removeFromSuperview()}

            transitionContext.completeTransition(!wasCancelled)
        }
    }
    func dismiss(fromView :UIView,fromViewController:UIViewController,transitionContext:UIViewControllerContextTransitioning,containerView:UIView) {
        
       let filterView = fromView.viewWithTag(1000)
//        fromView.frame = transitionContext.initialFrame(for: fromViewController)
        
        containerView.addSubview(fromView)
//        let dismissView = containerView.viewWithTag(1000)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
//            fromView.alpha = 0
            
            self.dismissView.alpha = 0
            filterView?.frame = CGRect(x: 0, y: -500, width: fromView.frame.width, height: fromView.frame.height)
            
        }) { (finshed :Bool) in
            let wasCanceled = transitionContext.transitionWasCancelled
            if wasCanceled {self.toView.removeFromSuperview()}

            transitionContext.completeTransition(!wasCanceled)
        }
    }
    func dimmingViewTapped() {
        toViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
