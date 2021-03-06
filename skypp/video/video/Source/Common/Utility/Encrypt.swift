//
//  Utility.swift
//  Ironhide
//
//  Created by zhongming.zhang on 2016/10/17.
//  Copyright © 2016年 Istuary. All rights reserved.
//

import Foundation
func md5_32(sources: String) -> String {
    let cString = sources.cString(using: String.Encoding.utf8)
    let length = CUnsignedInt(
        sources.lengthOfBytes(using: String.Encoding.utf8)
    )
    let result = UnsafeMutablePointer<CUnsignedChar>.allocate(
        capacity: Int(CC_MD5_DIGEST_LENGTH)
    )
    CC_MD5(cString!, length, result)
    return String(format:
        "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                  result[0], result[1], result[2], result[3],
                  result[4], result[5], result[6], result[7],
                  result[8], result[9], result[10], result[11],
                  result[12], result[13], result[14], result[15])
}
