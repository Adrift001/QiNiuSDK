//
//  ServiceProvider.swift
//  QiNiuSDK
//
//  Created by 荆学涛 on 2019/8/18.
//

public enum BucketProvider {
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
    /// 查询空间标签
    case queryBucketTags(String)
    /// 删除空间标签
    case deleteBucketTags(String)
    
    /// 修改文件状态
    case updateFileStatus(String, String, FileStatus)
    /// 修改文件存储类型
    case updateFileStoreType(String, String, FileStoreType)
    /// 修改文件生命周期
    case updateFileLife(String, String, Int)
    
    /// 查询文件元信息
    case queryFileMetaInfo(String, String)
    
    /// 资源元信息修改
    case updateFileMetaInfo(ResourceMetaInfo)
    /// 资源移动／重命名
    case renameFile(String, String, String, String, Bool)
    /// 资源拷贝
    case copyFile(String, String, String, String, Bool)
    /// 资源删除
    case deleteFile(String, String)
    /// 资源列举
    case querySource(String, String, String, String, String)
    
    /// 镜像资源更新
    case prefetchFile(String, String)
    
    /// 批量查询元数据
    case batchFileMetaInfo([BatchModel])
    
    /// 文件直传
    /// 创建块
    /// 上传片
    /// 追加文件
    /// 创建文件
}

extension BucketProvider: TargetType {
    
    public var baseURL: URL {
        switch self {
        case .buckets, .updateFileStatus, .updateFileMetaInfo, .batchFileMetaInfo:
            return URL(string: "https://rs.qbox.me/")!
        case .bucketSpaceDomainName:
            return URL(string: "https://api.qiniu.com/")!
        case .createBucket, .deleteBucket, .updateFileStoreType, .updateFileLife, .queryFileMetaInfo, .renameFile, .copyFile, .deleteFile:
            return URL(string: "https://rs.qiniu.com")!
        case .setBucketAccess, .setBucketTags, .queryBucketTags, .deleteBucketTags:
            return URL(string: "https://uc.qbox.me")!
        case .prefetchFile:
            return URL(string: "https://iovip.qbox.me")!
        case .querySource:
            return URL(string: "https://rsf.qbox.me")!
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
        case .queryBucketTags, .deleteBucketTags:
            return "bucketTagging"
        case .updateFileStatus(let encodedEntryUri, let fileName, let status):
            let encodedEntryUri = Base64FS.encodeString(str: "\(encodedEntryUri):\(fileName)")
            return "chstatus/\(encodedEntryUri)/status/\(status.rawValue)"
        case .updateFileStoreType(let bucketName, let fileName, let storeType):
            let encodedEntryUri = Base64FS.encodeString(str: "\(bucketName):\(fileName)")
            return "chtype/\(encodedEntryUri)/type/\(storeType.rawValue)"
        case .updateFileLife(let bucketName, let fileName, let life):
            let encodedEntryUri = Base64FS.encodeString(str: "\(bucketName):\(fileName)")
            return "deleteAfterDays/\(encodedEntryUri)/\(life)"
        case .queryFileMetaInfo(let bucketName, let fileName):
            let encodedEntryUri = Base64FS.encodeString(str: "\(bucketName):\(fileName)")
            return "stat/\(encodedEntryUri)"
        case .updateFileMetaInfo(let metaInfo):
            return "chgm/\(metaInfo.encodedEntryUri)/mime/\(metaInfo.encodedMimeType)/x-qn-meta-\(metaInfo.metaKey)/\(metaInfo.encodedMetaValue)/cond/\(metaInfo.encodedCond)"
        case .renameFile(let fromBucket, let fromFile, let toBucket, let toFile, let force):
            let fromEntry = Base64FS.encodeString(str: "\(fromBucket):\(fromFile)")
            let toEntry = Base64FS.encodeString(str: "\(toBucket):\(toFile)")
            return "move/\(fromEntry)/\(toEntry)/force/\(force)"
        case .copyFile(let fromBucket, let fromFile, let toBucket, let toFile, let force):
            let fromEntry = Base64FS.encodeString(str: "\(fromBucket):\(fromFile)")
            let toEntry = Base64FS.encodeString(str: "\(toBucket):\(toFile)")
            return "copy/\(fromEntry)/\(toEntry)/force/\(force)"
        case .deleteFile(let bucket, let file):
            let entry = Base64FS.encodeString(str: "\(bucket):\(file)")
            return "delete/\(entry)"
        case .prefetchFile(let bucket, let file):
            let entry = Base64FS.encodeString(str: "\(bucket):\(file)")
            return "prefetch/\(entry)"
        case .querySource:
            return "list"
        case .batchFileMetaInfo:
            return "batch"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .buckets, .createBucket, .deleteBucket, .setBucketAccess, .updateFileStatus, .queryFileMetaInfo, .updateFileLife, .updateFileStoreType, .updateFileMetaInfo, .deleteFile, .renameFile, .copyFile, .prefetchFile, .batchFileMetaInfo:
            return .POST
        case .bucketSpaceDomainName, .queryBucketTags, .querySource:
            return .GET
        case .setBucketTags:
            return .PUT
        case .deleteBucketTags:
            return .DELETE
        }
    }
    
    public var task: Task {
        switch self {
        case .buckets, .createBucket, .deleteBucket, .updateFileStatus, .updateFileStoreType, .queryFileMetaInfo, .updateFileLife, .updateFileMetaInfo, .renameFile, .copyFile, .deleteFile, .prefetchFile:
            return .requestPlain
        case .bucketSpaceDomainName(let bucketName):
            return .requestParameters(parameters: ["tbl": bucketName], encoding: URLEncoding.queryString)
        case .setBucketAccess(let bucketName, let access):
            return .requestParameters(parameters: ["bucket": bucketName, "private": access.rawValue], encoding: URLEncoding.queryString)
        case .setBucketTags(_, let tags):
            return .requestJSONEncodable(tags)
        case .queryBucketTags(let bucketName), .deleteBucketTags(let bucketName):
            return .requestParameters(parameters: ["bucket": bucketName], encoding: URLEncoding.queryString)
        case .querySource(let bucketName, let marker, let limit, let prefix, let delimiter):
            let encodedPrefix = Base64FS.encodeString(str: prefix)
            let encodedDelimiter = Base64FS.encodeString(str: delimiter)
            return .requestParameters(parameters: ["bucket": bucketName, "marker": marker, "limit": limit, "prefix": encodedPrefix, "delimiter": encodedDelimiter], encoding: URLEncoding.queryString)
        case .batchFileMetaInfo(let models):
            var operation = ""
            for (_, model) in models.enumerated() {
                if model.type == .stat || model.type == .delete || model.type == .restoreAr {
                    let encodedEntryURI = Base64FS.encodeString(str: "\(model.bucketName):\(model.fileName)")
                    operation += "op=/\(model.type.rawValue)/\(encodedEntryURI)"
                } else {
                    let fromEncodedEntryURI = Base64FS.encodeString(str: "\(model.fromBucketName):\(model.fromFileName)")
                    let toEncodedEntryURI = Base64FS.encodeString(str: "\(model.toBucketName):\(model.toFileName)")
                    operation += "op=/\(model.type.rawValue)/\(fromEncodedEntryURI)\(toEncodedEntryURI)/force/\(model.force)"
                }
            }
            return .requestCompositeData(bodyData: operation.data(using: .utf8)!, urlParameters: [:])
            
        }
    }
    
    public var body: Data? {
        switch self {
        case .setBucketTags(_, let tags):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(tags)
                return data
            } catch {
                return nil
            }
        default:
            return nil
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

extension BucketProvider {
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
    
    func formDataHeaders() -> [String: String] {
        return [
            "User-Agent": "QiNiuSDK",
            "Content-Type": "multipart/form-data"
        ]
    }
}
