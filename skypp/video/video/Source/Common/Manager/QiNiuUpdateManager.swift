//
//  File.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/7.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import Qiniu
import SwiftyJSON
import RealmSwift

final class QiNiuUpdateManager {
    
    /**
     上传图片
     
     - parameter image:          待上传图片
     - parameter progrssHandler: 进度更新
     - parameter successHandler: 上传成功
     - parameter failureHander:  上传失败
     */
    class func updateImage(_ image: UIImage, progrssHandler: @escaping QNUpProgressHandler, successHandler: ((_ url: String) -> Void)?, failureHander: ((_ error: NSError) -> Void)?) {
        QiNiuUpdateManager.getUpdateToken({ (token) in
                self.update(token, image: image, progrssHandler: progrssHandler, successHandler: successHandler, failureHander: failureHander)
            }) { (error) in
               failureHander?(error)
            }
    }
    
    /**
     批量上传图片
     
     - parameter images:          images
     - parameter progressHandler: progress changed
     - parameter successHandler:  update success
     - parameter failureHandler:  update failure
     */
    class func updateImages(_ images:[UIImage], progressHandler: ((_ progress: CGFloat) -> Void)?, successHandler: ((_ urls: [String]) -> Void)?, failureHandler: ((_ error: NSError) -> Void)?) {
        QiNiuUpdateManager.getUpdateToken({ (token) in
            var urlArray = Array<String>()
            var totalProgress: CGFloat = 0.0
            let partProgress: CGFloat = 1.0 / CGFloat(images.count)
            var currentIndex: Int = 0
            
            let uploadHelper = QiNiuUploadHelper.sharedInstance
            weak var weakHelper = uploadHelper
            
            uploadHelper.failureClosure = { (error) in
                failureHandler?(error)
                return
            }
            uploadHelper.successClosure = { (url) in
                urlArray.append(url)
                totalProgress += partProgress
                progressHandler?(totalProgress)
                currentIndex = currentIndex + 1
                if urlArray.count == images.count {
                    successHandler?(urlArray)
                    return
                } else {
                    self.update(token, image:images[currentIndex], progrssHandler:{_,_ in }, successHandler: weakHelper?.successClosure, failureHander: weakHelper?.failureClosure)
                }
            }
            self.update(token, image: images[0], progrssHandler: {_,_ in }, successHandler: weakHelper?.successClosure, failureHander: weakHelper?.failureClosure)
        }) { (error) in
            failureHandler?(error)
        }
    }
    
    private class func update(_ token: String, image: UIImage, progrssHandler: @escaping QNUpProgressHandler, successHandler: ((_ url: String) -> Void)?, failureHander: ((_ error: NSError) -> Void)?) {
        if let imageData = image.resizeData() {
            let option = QNUploadOption(mime: nil, progressHandler: progrssHandler, params: nil, checkCrc: false, cancellationSignal: nil)
            let uploadManager = QNUploadManager.sharedInstance(with: nil)
            
            uploadManager?.put((imageData as Data), key: nil, token: token, complete: { (info, key, response) in
                if let resp = response , info?.statusCode == 200 {
                    if let url = JSON(resp)["key"].string {
                        successHandler?(url)
                    } else {
                        failureHander?(self.createUpdateError("upload multiple image error"))
                    }
                }else {
                    failureHander?(self.createUpdateError("upload image error"))
                }
                }, option: option)
            
        } else {
            
            failureHander?(self.createUpdateError("upload image error"))
        }
    }
    
    /**
     get update token
     
     - parameter success: handler
     - parameter failure: handler
     */
    private class func getUpdateToken(_ success: ((_ token: String) -> Void)?, failure: ((_ error: NSError) -> Void)?) {
        SettingAPI.getUpdateToken { (result) in
            result.success({ (token) in
                success?(token.uptoken)
            }).failure({ (error, obj) in
                failure?(error)
            })
        }
    }
    
    private class func createUpdateError(_ message: String) -> NSError{
        return NSError(domain: HTTPResponseKeys.ErrorDomain, code: -1, userInfo: [HTTPResponseKeys.ErrorKey : message])
    }

}

class QiNiuUploadHelper {
    
    var successClosure: ((_ url: String) -> Void)?
    var failureClosure: ((_ error: NSError) -> Void)?

    class var sharedInstance : QiNiuUploadHelper {
        struct Static {
            static let instance : QiNiuUploadHelper = QiNiuUploadHelper()
        }
        return Static.instance
    }
}
