//
//  Define.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//
public typealias Request = HTTPClient.Request
public typealias Response = HTTPClient.Response
public typealias Body = HTTPClient.Body

public enum BucketAccess: String {
    case `public` = "0"
    case `private` = "1"
}

extension Request: RequestType {
    public var request: Request? {
        return self
    }
}
