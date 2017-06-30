//
//  ImageLayer.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/10/26.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import UIKit
import SDWebImage

enum  ImageLayerType{
    case Image
}

let CATransactionCommitRunLoopOrder: CFIndex = 2000000
let POPAnimationApplyRunLoopOrder: CFIndex = CATransactionCommitRunLoopOrder - 1

class ImageLayer: CALayer {
    
    
    override init() {
        super.init()
        self.contentsGravity = kCAGravityResizeAspect
        self.backgroundColor = UIColor(argb: 0xffF0F0F0).cgColor
        self.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var observer: CFRunLoopObserver?
    private var startLocation:  CGPoint?
    private var highlightImage: UIImage?
    
    var originImage: UIImage?
    var imageUrl: String?
    var imageIndex: Int = 0
    var touchUpInsideClosure: (() -> Void)?
    
    func setImageWithURLString(urlString: String,  defaultImage: UIImage? = I.Image.default_image_183x183!) {
        
        if self.imageUrl == urlString {
            return
        }
        self.imageUrl = urlString
        self.contentsGravity = kCAGravityResizeAspect
        self.contents = defaultImage?.cgImage
        SDWebImageManager.shared().downloadImage(with: URL(string: urlString), options: SDWebImageOptions.cacheMemoryOnly, progress: nil) { [weak self] (image, error, cacheType, finshed, imageUrl) in
            
            if let myself = self {
                if let realImage = image {
                    DispatchQueue.global().async {
                        if let _ = myself.observer { } else {
                            myself.observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.beforeWaiting.rawValue | CFRunLoopActivity.exit.rawValue, false, POPAnimationApplyRunLoopOrder, { (observer, activity) in
                                myself.contentsGravity = kCAGravityResizeAspectFill
                                if cacheType == SDImageCacheType.none {
                                   myself.contents = realImage.cgImage
                                    let transition = CATransition()
                                    transition.type = kCATransitionFade
                                    myself.add(transition, forKey: nil)
                                } else {
                                    myself.contents = realImage.cgImage
                                }
                                if let returnObserver = observer {
                                    CFRunLoopRemoveObserver(CFRunLoopGetMain(), returnObserver, CFRunLoopMode.commonModes)
                                }
                            })
                            if let myObserver = myself.observer {
                                CFRunLoopAddObserver(CFRunLoopGetMain(), myObserver, CFRunLoopMode.commonModes)
                            }
                        }
                    }
                    myself.originImage = realImage
                }
            }
        }
    }
    
    func clearPendingListObserver() {
        if let myObserver = self.observer {
            CFRunLoopRemoveObserver(CFRunLoopGetMain(), myObserver, CFRunLoopMode.commonModes)
            self.observer = nil
        }
    }

    func highlightedImage() {
        if self.highlightImage == nil {
            self.highlightImage = self.originImage?.colorizeImageWithColor(UIColor.gray)
        }
        if let myHighlightImage = self.highlightImage {
           self.contents = myHighlightImage.cgImage
        }
    }
    
    func unhighlightedImage() {
        if let myOriginImage = self.originImage {
            self.contents = myOriginImage.cgImage
        }
    }
    
    
    func touchBeginPoint(point: CGPoint) -> Bool {
        guard let _ = self.originImage else {
            return false
        }
        self.startLocation = point
        if (self.frame.contains(point)) {
            self.highlightedImage()
            return true
        }
        return false
    }
    
    func touchCancelPoint() {
        guard let _ = self.originImage else {
            return
        }
        self.unhighlightedImage()
    }
    
    func touchEndPoint(point: CGPoint) -> Bool {
        
        guard let _ = self.originImage else {
            return false
        }
        self.unhighlightedImage()
        if let touchStartLocation = self.startLocation {
            if (self.frame.contains(point) && self.frame.contains(touchStartLocation)) {
                self.touchUpInsideClosure?()
                return true
            }
        }
        return false
    }
    
}
