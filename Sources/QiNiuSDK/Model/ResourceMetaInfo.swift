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
    var cond: ResourceMetaInfoCond
    
    init(bucketName: String, fileName: String, mimeType: String, metaKey: String, metaValue: String, cond: ResourceMetaInfoCond) {
        self.bucketName = bucketName
        self.fileName = fileName
        self.mimeType = mimeType
        self.metaKey = metaKey
        self.metaValue = metaValue
        self.cond = cond
    }
    
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
        if !cond.hash.isEmpty {
            result += "hash=\(cond.hash)&"
        }
        if !cond.mime.isEmpty {
            result += "mime=\(cond.mime)&"
        }
        if cond.fsize != 0 {
            result += "fsize=\(cond.fsize)&"
        }
        if !cond.putTime.isEmpty {
            result += "putTime=\(cond.putTime)&"
        }
        print("==========")
        print(String(result.dropLast()))
        print("==========")
        if !result.isEmpty {
            return Base64FS.encodeString(str: String(result.dropLast()))
        }
        return ""
    }
}

public struct ResourceMetaInfoCond: Codable {
    var hash = ""
    var mime = ""
    var fsize = 0
    var putTime = ""
    init(hash: String, mime: String, fsize: Int, putTime: String) {
        self.hash = hash
        self.mime = mime
        self.fsize = fsize
        self.putTime = putTime
    }
}
