//
//  ServiceProvider.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

public enum QiNiuProvider {
    case buckets
}

extension QiNiuProvider: TargetType {
    public var baseURL: URL {
        switch self {
        case .buckets:
            return URL(string: "https://rs.qbox.me/")!
        }
    }
    
    public var path: String {
        switch self {
        case .buckets:
            return "buckets"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .buckets:
            return .POST
        }
    }
    
    public var task: Task {
        switch self {
        case .buckets:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return [:]
    }
}
