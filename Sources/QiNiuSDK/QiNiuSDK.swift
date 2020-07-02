//
//  QiNiuSDK.swift
//  QiNiuSDK
//
//  Created by swifter on 2020/1/9.
//

import Foundation

public class QiNiuSDK {
    
    public static let shared = QiNiuSDK()
    
    let provider = Provider<BucketProvider>()
    
    //MARK: - 空间
    /// 获取列表名称
    /// - Parameter completionHandler: 获取列表名称回调
    public func bucket(completionHandler: @escaping (Result<[String], Error>) -> Void) {
        let task = provider.request(.buckets)
        task.mapCodable([String].self).whenComplete { (result) in
            switch result {
            case .success(let arr):
                completionHandler(.success(arr))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 获取 Bucket 空间域名
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - completionHandler: 获取空间名称回调
    public func bucket(bucketName: String, completionHandler: @escaping (Result<[String], Error>) -> Void) {
        let task = provider.request(.bucketSpaceDomainName(bucketName))
        task.mapCodable([String].self).whenComplete { (result) in
            switch result {
            case .success(let arr):
                completionHandler(.success(arr))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    /// 创建 Bucket, 空间名称,地区 (空间名称不能有下划线,可以用中划线)
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - region: 地区
    ///   - completionHandler: 创建空间名称回调
    public func createBucket(bucketName: String, region: Region, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let task = provider.request(.createBucket(bucketName, region))
        task.mapCodable(String.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                completionHandler(.success(string))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 删除指定的 Bucket
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - completionHandler: 删除空间名称回调
    public func deleteBucket(bucketName: String, completionHandler: @escaping (Result<EmptyModel, Error>) -> Void) {
        let task = provider.request(.deleteBucket(bucketName))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 设置 Bucket 访问权限
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - access: 权限类型
    ///   - completionHandler: 设置权限回调
    public func setBucketAccess(bucketName: String, access: BucketAccess, completionHandler: @escaping (Result<EmptyModel, Error>) -> Void) {
        let task = provider.request(.setBucketAccess("jingxuetao-hello", .private))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 设置空间标签
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - tags: 标签列表
    ///   - completionHandler: 设置空间标签回调
    public func setBucketTags(bucketName: String, tags: [BucketTagModel], completionHandler: @escaping (Result<EmptyModel, Error>) -> Void) {
        let task = provider.request(.setBucketTags(bucketName, BucketTagsModel(Tags: tags)))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 查询空间标签
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - completionHandler: 查询空间标签回调
    public func queryBucketTags(bucketName: String, completionHandler: @escaping (Result<BucketTagsModel, Error>) -> Void) {
        let task = provider.request(.queryBucketTags(bucketName))
        task.mapCodable(BucketTagsModel.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 删除空间标签
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - completionHandler: 删除空间名称回调
    public func deleteBucketTags(bucketName: String, completionHandler: @escaping (Result<EmptyModel, Error>) -> Void) {
        let task = provider.request(.deleteBucketTags(bucketName))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    //MARK: - 文件操作
    /// 修改文件状态
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - fileName: 文件名称
    ///   - status: 文件状态
    ///   - completionHandler: 修改文件状态回调
    public func updateFileStatus(bucketName: String, fileName: String, status: FileStatus, completionHandler: @escaping (Result<EmptyModel, Error>) -> Void) {
        let task = provider.request(.updateFileStatus(bucketName, fileName, status))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 修改文件存储类型
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - fileName: 文件名称
    ///   - type: 存储类型
    ///   - completionHandler: 修改存储类型回调
    public func updateFileStoreType(bucketName: String, fileName: String, type: FileStoreType, completionHandler: @escaping (Result<EmptyModel, Error>) -> Void) {
        let task = provider.request(.updateFileStoreType(bucketName, fileName, type))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 修改文件生命周期 (多少天后被删除)
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - fileName: 文件名称
    ///   - day: 天数
    ///   - completionHandler: 修改文件声明周期回调
    public func updateFileLife(bucketName: String, fileName: String, day: Int, completionHandler: @escaping (Result<EmptyModel, Error>) -> Void) {
        let task = provider.request(.updateFileLife(bucketName, fileName, day))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 查询文件元信息
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - fileName: 文件名称
    ///   - completionHandler: 查询文件云信息回调
    public func queryFileMetaInfo(bucketName: String, fileName: String, completionHandler: @escaping (Result<FileInfo, Error>) -> Void) {
        let task = provider.request(.queryFileMetaInfo(bucketName, fileName))
        task.mapCodable(FileInfo.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 文件移动／重命名
    /// - Parameters:
    ///   - fromBucket: 从空间名称
    ///   - fromFile: 从文件名称
    ///   - toBucket: 到空间名称
    ///   - toFile: 到文件名称
    ///   - force: 是否强制移动
    ///   - completionHandler: 文件移动/重命名回调
    public func renameFile(fromBucket: String, fromFile: String, toBucket: String, toFile: String, force: Bool, completionHandler: @escaping (Result<FileInfo, Error>) -> Void) {
        let task = provider.request(.renameFile(fromBucket, fromFile, toBucket, toFile, force))
        task.mapCodable(FileInfo.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 文件复制
    /// - Parameters:
    ///   - fromBucket: 从空间名称
    ///   - fromFile: 从文件名称
    ///   - toBucket: 到空间名称
    ///   - toFile: 到文件名称
    ///   - force: 是否强制复制
    ///   - completionHandler: 文件移动/重命名回调
    public func copyFile(fromBucket: String, fromFile: String, toBucket: String, toFile: String, force: Bool, completionHandler: @escaping (Result<FileInfo, Error>) -> Void) {
        let task = provider.request(.copyFile(fromBucket, fromFile, toBucket, toFile, force))
        task.mapCodable(FileInfo.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 资源删除
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - fileName: 文件名称
    ///   - completionHandler: 资源删除回调
    public func deleteFile(bucketName: String, fileName: String, completionHandler: @escaping (Result<EmptyModel, Error>) -> Void) {
        let task = provider.request(.deleteFile(bucketName, fileName))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 资源列举
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - marker: 上一次列举返回的位置标记，作为本次列举的起点信息。默认值为空字符串。
    ///   - limit: 本次列举的条目数，范围为1-1000。默认值为1000。
    ///   - prefix: 指定前缀，只有资源名匹配该前缀的资源会被列出。默认值为空字符串。
    ///   - deimiter: 指定目录分隔符，列出所有公共前缀（模拟列出目录效果）。默认值为空字符串。
    ///   - completionHandler: 资源列举回调
    public func querySource(bucketName: String, marker: String, limit: String, prefix: String, deimiter: String, completionHandler: @escaping (Result<QuerySource, Error>) -> Void) {
        let task = provider.request(.querySource(bucketName, marker, limit, prefix, deimiter))
        task.mapCodable(QuerySource.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    /// 资源批量列举
    /// - Parameters:
    ///   - bucketName: 空间名称
    ///   - fileNames: 文件名称
    ///   - completionHandler: 批量列举回调
    public func batchFileMetaInfo(models: [BatchModel], completionHandler: @escaping (Result<QuerySource, Error>) -> Void) {
        let task = provider.request(.batchFileMetaInfo(models))
        task.mapCodable(QuerySource.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
