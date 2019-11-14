//
//  ServiceProvider.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

public enum QiNiuProvider {
    /// 获取 Bucket 列表
    case buckets
    /// 获取 Bucket 空间域名
    case bucketSpaceDomainName(String)
    /// 创建 Bucket, 空间名称,地区 (空间名称不能有下划线,可以用中划线)
    case createBucket(String, Region)
}

extension QiNiuProvider: TargetType {
    public var baseURL: URL {
        switch self {
        case .buckets:
            return URL(string: "https://rs.qbox.me/")!
        case .bucketSpaceDomainName:
            return URL(string: "https://api.qiniu.com/")!
        case .createBucket:
            return URL(string: "https://rs.qiniu.com")!
        }
    }
    
    public var path: String {
        switch self {
        case .buckets:
            return "buckets"
        case .bucketSpaceDomainName:
            return "v6/domain/list"
        case .createBucket(let bucketName, let region):
            return "mkbucketv3/\(bucketName)/region/\(region.rawValue)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .buckets, .createBucket:
            return .POST
        case .bucketSpaceDomainName:
            return .GET
        }
    }
    
    public var task: Task {
        switch self {
        case .buckets, .createBucket:
            return .requestPlain
        case .bucketSpaceDomainName(let bucketName):
            return .requestParameters(parameters: ["tbl": bucketName], encoding: Encoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return defaultHeaders()
    }
}

extension QiNiuProvider {
    func defaultHeaders() -> [String: String] {
        return [
            "User-Agent": "QiNiuSDK",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
}
