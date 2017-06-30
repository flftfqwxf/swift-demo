//
//  CacheManager.swift
//  Ironhide
//
//  Created by zhongming.zhang on 16/7/6.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
import SDWebImage

class CacheManager {

    class var sharedInstance : CacheManager {
        struct Static {
            static let instance : CacheManager = CacheManager()
        }
        return Static.instance
    }
    
}


extension CacheManager {
    
    private enum CacheType : String {
        case kLoginAccountNameKey
    }
    
    func saveLoginUserName(_ username: String!) {
        UserDefaults.standard.set(username, forKey: CacheType.kLoginAccountNameKey.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func cachedLoginUserName() -> String? {
        return UserDefaults.standard.string(forKey: CacheType.kLoginAccountNameKey.rawValue)
    }
}

extension CacheManager {
    
    func cacheInit() {
        SDImageCache.shared().maxCacheSize = UInt(100 * 1024 * 1024)
        SDImageCache.shared().maxCacheAge = 60 * 60 * 24 * 3
        SDImageCache.shared().shouldDisableiCloud = false
        let urlCache = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)
        URLCache.shared = urlCache
    }
    
    func cleanCache(_ completionHander: (() -> Void )?) {
        DispatchQueue.global().async {
            URLCache.shared.removeAllCachedResponses()
            SDImageCache.shared().clearMemory()
            SDImageCache.shared().clearDisk {
                DispatchQueue.main.async {
                    completionHander?()
                }
            }
        }
    }
    
    func calculateCache(_ completionHander: ((String) -> Void)?) {
        DispatchQueue.global().async {
            let size = SDImageCache.shared().getSize()
            DispatchQueue.main.async {
                completionHander?(self.formatSizeString(size))
            }
        }
    }
    
    func formatSizeString(_ size: UInt) -> String {
        var mysize = CGFloat(size)
        if mysize < 1024 {
            return String(format: "%lld bytes", mysize)
        }
        mysize = mysize / 1024
        if mysize < 1024 {
            return String(format: "%.1f KB", mysize)
        }
        mysize = mysize / 1024
        if mysize < 1024 {
            return String(format: "%.1f MB", mysize)
        }
        mysize = mysize / 1024
        if mysize < 1024 {
            return String(format: "%.1f GB", mysize)
        }
        return String(format: "%.1f GB", mysize)
    }
    
}
