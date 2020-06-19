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
