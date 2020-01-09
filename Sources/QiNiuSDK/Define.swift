//
//  Define.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//
public typealias Request = HTTPClient.Request
public typealias Response = HTTPClient.Response
public typealias Body = HTTPClient.Body

public enum BucketAccess: Int {
    case `public` = 0
    case `private` = 1
}

extension Request: RequestType {
    public var request: Request? {
        return self
    }
}

public enum FileStatus: Int {
    case enable = 0
    case disable = 1
}

public enum FileStoreType: Int {
    case standard = 0
    case low = 1
}

/// 上传服务器域名
public enum UploadServer: String {
    /// 华东一
    case ec1 = "up.qiniup.com"
    /// 华东二
    case ec2 = "up-z0.qiniup.com"
    /// 华东三
    case ec3 = "upload.qiniup.com"
    /// 华北一
    case nc1 = "up-z1.qiniup.com"
    /// 华北二
    case nc2 = "upload-z1.qiniup.com"
    /// 华南一
    case sc1 = "up-z2.qiniup.com"
    /// 华南二
    case sc2 = "upload-z2.qiniup.com"
    /// 北美一
    case na1 = "up-na0.qiniup.com"
    /// 北美二
    case na2 = "upload-na0.qiniup.com"
    /// 东南亚一
    case sa1 = "up-as0.qiniup.com"
     /// 东南亚二
    case sa2 = "upload-as0.qiniup.com"
}
