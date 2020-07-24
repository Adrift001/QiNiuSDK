//
//  BucketManager.swift
//  
//
//  Created by swifter on 2020/7/24.
//

import Foundation
import AsyncHTTPClient

public class BucketManager {
    
    let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    func encodedEntry(bucketName: String, key: String = "") -> String {
        if key.isEmpty {
            return Base64FS.encodeString(str: "\(bucketName)")
        }
        return Base64FS.encodeString(str: "\(bucketName):\(key)")
    }
    
    /// 获取账号下所有空间名称列表
    func buckets() {
        
    }
    
    /// 创建空间
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - region: 地区
    func createBucket(bucketName: String, region: String) {
        
    }
    
    /// 获取该空间下所有的domain
    /// - Parameter bucketName: 空间名称
    func domainList(bucketName: String) {
        
    }
    
    /// 获取空间中文件属性
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - fileKey: 文件名称
    func stat(bucketName: String, fileKey: String) {
        
    }
    
    
    /// 删除指定空间, 指定文件
    /// - Parameters:
    ///   - bucket: 空间名称
    ///   - key: 文件名称
    func delete(bucket: String, key: String) {
        
    }
    
    /// 修改文件的MimeType
    /// - Parameters:
    ///   - bucket: 空间名称
    ///   - key: 文件名称
    ///   - mime: mime类型
    func changeMime(bucket: String, key: String, mime: String) {
        
    }
    
    /// 修改文件的元数据
    /// - Parameters:
    ///   - bucket: 空间名称
    ///   - key: 文件名称
    ///   - headers: 元数据
    func changeHeaders(bucket: String, key: String, headers: [String: String]) {
        
    }
    
    /// 修改文件的类型（普通存储或低频存储）
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - key: 文件名称
    ///   - storageType: 存储类型
    func changeType(bucketName: String, key: String, storageType: Int) {
        
    }
    
    /// 解冻归档存储
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - key: 文件名称
    ///   - freezeAfterDays: 解冻有效时长，取值范围 1～7
    func restoreArchive(bucketName: String, key: String, freezeAfterDays: Int) {
        
    }
    
    
    /// 修改文件的状态（禁用或者正常）
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - key: 文件名称
    ///   - status: 状态, 0表示启用；1表示禁用。
    func changeStatus(bucketName: String, key: String, status: Int) {
        
    }
    
    /// 重命名空间中的文件，可以设置force参数为true强行覆盖空间已有同名文件
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - oldFileKey: 文件名称
    ///   - newFileKey: 新文件名称
    ///   - force: 强制覆盖空间中已有同名（和 newFileKey 相同）的文件
    func rename(bucketName: String, oldFileKey: String, newFileKey: String, force: Bool = false) {
        
    }
}
