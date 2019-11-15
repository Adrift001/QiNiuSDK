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
    /// 删除指定的 Bucket
    case deleteBucket(String)
    /// 设置 Bucket 访问权限
    case setBucketAccess(String, BucketAccess)
    /// 设置空间标签
    case setBucketTags(String, BucketTagsModel)
}

extension QiNiuProvider: TargetType {
    public var baseURL: URL {
        switch self {
        case .buckets:
            return URL(string: "https://rs.qbox.me/")!
        case .bucketSpaceDomainName:
            return URL(string: "https://api.qiniu.com/")!
        case .createBucket, .deleteBucket:
            return URL(string: "https://rs.qiniu.com")!
        case .setBucketAccess, .setBucketTags:
            return URL(string: "https://uc.qbox.me")!
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
        case .deleteBucket(let bucketName):
            return "drop/\(bucketName)"
        case .setBucketAccess:
            return "private"
        case .setBucketTags(let bucketName, _):
            return "bucketTagging?bucket=\(bucketName)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .buckets, .createBucket, .deleteBucket, .setBucketAccess:
            return .POST
        case .bucketSpaceDomainName:
            return .GET
        case .setBucketTags:
            return .PUT
        }
    }
    
    public var task: Task {
        switch self {
        case .buckets, .createBucket, .deleteBucket:
            return .requestPlain
        case .bucketSpaceDomainName(let bucketName):
            return .requestParameters(parameters: ["tbl": bucketName], encoding: URLEncoding.queryString)
        case .setBucketAccess(let bucketName, let access):
            return .requestParameters(parameters: ["bucket": bucketName, "private": access.rawValue], encoding: URLEncoding.queryString)
        case .setBucketTags(_, let tags):
            return .requestJSONEncodable(tags)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .setBucketTags:
            return jsonEncodingHeaders()
        default:
            return urlEncodingHeaders()
        }
    }
}

extension QiNiuProvider {
    func urlEncodingHeaders() -> [String: String] {
        return [
            "User-Agent": "QiNiuSDK",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
    
    func jsonEncodingHeaders() -> [String: String] {
        return [
            "User-Agent": "QiNiuSDK",
            "Content-Type": "application/json"
        ]
    }
}
