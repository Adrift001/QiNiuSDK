//
//  File.swift
//  
//
//  Created by swifter on 2020/7/31.
//

import Vapor

public struct QiNiuSDK {
    
    public let application: Application
    
    func defaultEndpoint(for target: BucketProvider) -> Endpoint {
        let point = Endpoint(
            url: URI(target: target),
            method: target.method,
            task: target.task,
            headers: target.headers,
            body: target.body
        )
        signRequest(endpoint: point)
        return point
    }
    
    func defaultEventLoopFuture(_ endpoint: Endpoint) -> EventLoopFuture<ClientResponse> {
        switch endpoint.method {
        case .GET:
            return application.client.get(endpoint)
        case .POST:
            return application.client.post(endpoint)
        case .PUT:
            return application.client.put(endpoint)
        case .DELETE:
            return application.client.delete(endpoint)
        default:
            return application.client.get(endpoint)
        }
    }
    
    func encodedEntry(bucketName: String, key: String = "") -> String {
        if key.isEmpty {
            return Base64FS.encodeString(str: "\(bucketName)")
        }
        return Base64FS.encodeString(str: "\(bucketName):\(key)")
    }
    
    /// 获取账号下所有空间名称列表
    func buckets() throws {
        let endpoint = defaultEndpoint(for: .buckets)
        let res = try defaultEventLoopFuture(endpoint).wait()
        print(res)
    }
    
    /// 创建空间
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - region: 地区
    func createBucket(bucketName: String, region: Region) throws {
        let endpoint = defaultEndpoint(for: .createBucket(bucketName, region))
        let res = try defaultEventLoopFuture(endpoint).wait()
        print(res)
    }
    
    /// 删除空间
    /// - Parameter bucketName: 空间名称
    func deleteBucket(bucketName: String) throws {
        let endpoint = defaultEndpoint(for: .deleteBucket(bucketName))
        let res = try defaultEventLoopFuture(endpoint).wait()
        print(res)
    }
    
    /// 获取该空间下所有的domain
    /// - Parameter bucketName: 空间名称
    func domainList(bucketName: String) throws  {
        let endpoint = defaultEndpoint(for: .bucketSpaceDomainName(bucketName))
        let res = try defaultEventLoopFuture(endpoint).wait()
        print(res)
    }
    
    /// 获取空间中文件属性
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - fileKey: 文件名称
    func stat(bucketName: String, fileKey: String) throws {
        let endpoint = defaultEndpoint(for: .queryFileMetaInfo(bucketName, fileKey))
        let res = try defaultEventLoopFuture(endpoint).wait()
        print(res)
    }
    
    
    /// 删除指定空间的指定文件
    /// - Parameters:
    ///   - bucket: 空间名称
    ///   - key: 文件名称
    func deleteFile(bucketName: String, key: String) throws {
        let endpoint = defaultEndpoint(for: .deleteFile(bucketName, key))
        let res = try defaultEventLoopFuture(endpoint).wait()
        print(res)
    }
    
    /// 修改文件的MimeType
    /// - Parameters:
    ///   - bucket: 空间名称
    ///   - key: 文件名称
    ///   - mime: mime类型
    func changeMime(bucket: String, key: String, mime: String) throws {
        
    }
    
    /// 修改文件的元数据
    /// - Parameters:
    ///   - bucket: 空间名称
    ///   - key: 文件名称
    ///   - headers: 元数据
    func changeHeaders(bucket: String, key: String, headers: [String: String]) throws {
        
    }
    
    /// 修改文件的类型（普通存储或低频存储）
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - key: 文件名称
    ///   - storageType: 存储类型
    func changeType(bucketName: String, key: String, storageType: Int) throws {
        
    }
    
    /// 解冻归档存储
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - key: 文件名称
    ///   - freezeAfterDays: 解冻有效时长，取值范围 1～7
    func restoreArchive(bucketName: String, key: String, freezeAfterDays: Int) throws {
        
    }
    
    /// 修改文件的状态（禁用或者正常）
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - key: 文件名称
    ///   - status: 状态, 0表示启用；1表示禁用。
    func changeStatus(bucketName: String, key: String, status: Int) throws {
        
    }
    
    /// 重命名空间中的文件，可以设置force参数为true强行覆盖空间已有同名文件
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - oldFileKey: 文件名称
    ///   - newFileKey: 新文件名称
    ///   - force: 强制覆盖空间中已有同名（和 newFileKey 相同）的文件
    func rename(bucketName: String, oldFileKey: String, newFileKey: String, force: Bool = false) throws {
        
    }
    
    /// 复制文件，要求空间在同一账号下，可以设置force参数为true强行覆盖空间已有同名文件
    /// - Parameters:
    ///   - fromBucket: 源空间名称
    ///   - fromFileKey: 源文件名称
    ///   - toBucket: 目的空间名称
    ///   - toFileKey: 目的文件名称
    ///   - force: 强制覆盖空间中已有同名（和 toFileKey 相同）的文件
    func copy(fromBucket: String, fromFileKey: String, toBucket: String, toFileKey: String, force: Bool = false) throws {
        
    }
    
    /// 移动文件，要求空间在同一账号下
    /// - Parameters:
    ///   - fromBucket: 源空间名称
    ///   - fromFileKey: 源文件名称
    ///   - toBucket: 目的空间名称
    ///   - toFileKey: 目的文件名称
    ///   - force: 强制覆盖空间中已有同名（和 toFileKey 相同）的文件
    func move(fromBucket: String, fromFileKey: String, toBucket: String, toFileKey: String, force: Bool = false) throws {
        
    }
    
    func signRequest(endpoint: Endpoint) {
        let method = endpoint.method
        let path = endpoint.uri.path
        let query = endpoint.uri.query == nil ? "" : "?\(endpoint.uri.query ?? "")"
        let host = endpoint.uri.host ?? ""
        let contentType = endpoint.headers["Content-Type"].first ?? ""
        var signingStr = """
        \(method) \(path)\(query)
        Host: \(host)
        """
        if !contentType.isEmpty {
            signingStr.append("\nContent-Type: \(contentType)")
        }
        signingStr.append("\n\n")
        print("==========signingStr==========")
        print(signingStr)
        print("==========signingStr==========")
        endpoint.headers.add(name: "Authorization", value: "Qiniu \(Auth.accessToken(signingStr: signingStr))")
    
        print("===========headers===========")
        print(endpoint.headers)
        print("===========headers===========")
    }

    func test() throws {
        var headers = HTTPHeaders()
        headers.add(contentsOf: urlEncodingHeaders)
        let res = try application.client.get("https://httpbin.org/get", headers: headers).wait()
        print("============")
        print(res)
        print("============")
    }
    
    var urlEncodingHeaders: [(String, String)] {
        return [
            ("User-Agent", "QiNiuSDK"),
            ("Content-Type", "application/x-www-form-urlencoded")
        ]
    }
    
    var jsonEncodingHeaders: [(String, String)] {
        return [
            ("User-Agent", "QiNiuSDK"),
            ("Content-Type", "application/json")
        ]
    }
    
    var formDataHeaders: [(String, String)] {
        return [
            ("User-Agent", "QiNiuSDK"),
            ("Content-Type", "multipart/form-data")
        ]
    }
}
