//
//  ResourceMetaInfo.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/11/18.
//

public struct ResourceMetaInfo: Codable {
    var bucketName: String
    var fileName: String
    var mimeType: String
    var metaKey: String
    var metaValue: String
    var cond: [String: String] = [:]
    
    var encodedEntryUri: String {
        return Base64FS.encodeString(str: "\(bucketName):\(fileName)")
    }
    
    var encodedMimeType: String {
        return Base64FS.encodeString(str: mimeType)
    }
    
    var encodedMetaValue: String {
        return Base64FS.encodeString(str: metaValue)
    }
    
    var encodedCond: String {
        var result = ""
        for (index, dic) in cond.enumerated() {
            if index == cond.count - 1 {
                result += "\(dic.key)=\(dic.value)"
            } else {
                result += "\(dic.key)=\(dic.value)&"
            }
        }
        return Base64FS.encodeString(str: result)
    }
}
