//
//  ServiceTests.swift
//  QiNiuSDKTests
//
//  Created by 荆学涛 on 2019/8/17.
//

import XCTest
@testable import QiNiuSDK
@testable import CryptoSwift
@testable import AsyncHTTPClient
@testable import NIOHTTP1
@testable import NIO

final class BucketTests: XCTestCase {
    let timeout: TimeInterval = 5
    var provider:Provider<BucketProvider>!
    
    override func setUp() {
        super.setUp()
        Keys.accessKey = ""
        Keys.secretKey = ""
        provider = Provider<BucketProvider>(plugins: [AuthPlugin(), NetworkLoggerPlugin(verbose: true),])
    }
    
    func testHMAC() {
        let message = "123123abcd\n"
        let key = "123"
        let sign = try! HMAC(key: key.bytes, variant: .sha1).authenticate(message.bytes)
        print(sign.toHexString())
    }
    
    func testToken() {
        //正确结果: b1d6d455b40504e1d4ca2985eb9899286be2e038
        print("====================")
        print(Keys.accessKey)
        print(Keys.secretKey)
        print("====================")
        
        let signingStr = "POST /buckets\nHost: rs.qbox.me\nContent-Type: application/x-www-form-urlencoded\n\n"
        let sign = try! HMAC(key: Keys.secretKey.bytes, variant: .sha1).authenticate(signingStr.bytes)
        print(sign.toHexString())
        print( Base64FS.encode(data: sign).toHexString())
        print( Base64FS.encode(data: sign).toBase64() ?? "")
        let encodedSign = String(bytes: Base64FS.encode(data: Array(sign.toHexString().utf8)), encoding: .utf8) ?? ""
        print(encodedSign)
    }
    
    func testBuckets() throws {
        provider = Provider<BucketProvider>(plugins: [AuthPlugin(), NetworkLoggerPlugin(verbose: true),])
        let task = provider.request(.buckets)
        task.mapCodable([String].self).whenComplete { (result) in
            switch result {
            case .success(let arr):
                print(arr)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testBucketSpaceDomainName() throws {
        let task = provider.request(.bucketSpaceDomainName("blog-pic"))
        task.mapCodable([String].self).whenComplete { (result) in
            switch result {
            case .success(let arr):
                print(arr)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testCreateBucket() throws {
        let task = provider.request(.createBucket("jingxuetao-hello", .z0))
        task.mapCodable(String.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testDeleteBucket() throws {
        let task = provider.request(.deleteBucket("jingxuetao-hello"))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testSetBucketAccess() throws {
        let task = provider.request(.setBucketAccess("jingxuetao-hello", .private))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testSetBucketTags() throws {
        let task = provider.request(.setBucketTags("jingxuetao-hello", BucketTagsModel(Tags: [BucketTagModel(Key: "key1", Value: "value1")])))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testQueryBucketTags() throws {
        let task = provider.request(.queryBucketTags("jingxuetao-hello"))
        task.mapCodable(BucketTagsModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testDeleteBucketTags() throws {
        let task = provider.request(.deleteBucketTags("jingxuetao-hello"))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testUpdateFileStatus() throws {
        let task = provider.request(.updateFileStatus("blog-pic", "1.png", .disable))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testUpdateFileStoreType() throws {
        let task = provider.request(.updateFileStoreType("blog-pic", "1.png", .low))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testUpdateFileLife() throws {
        let task = provider.request(.updateFileLife("blog-pic", "1.png", 100))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testUpdateFileInfo() throws {
        let task = provider.request(.queryFileMetaInfo("blog-pic", "1.png"))
        task.mapCodable(FileInfo.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testRenameFile() throws {
        let task = provider.request(.renameFile("blog-pic", "1.png", "blog-pic", "1111111111.png", true))
        task.mapCodable(FileInfo.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testPrefetchFile() throws {
        
        
        let task = provider.request(.prefetchFile("blog-pic", "1111111111.png"))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    #warning("待验证")
    func testUpdateMetaInfo() throws {
        let metaInfo = ResourceMetaInfo(bucketName: "blog-pic", fileName: "1111111111.png", mimeType: "jpg", metaKey: "jpg_key", metaValue: "jpg_value", cond: ResourceMetaInfoCond(hash: "", mime: "image/jpg", fsize: 0, putTime: ""))
        print(metaInfo.cond)
        
        let task = provider.request(.updateFileMetaInfo(metaInfo))
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testQuerySource() throws {
        
        let task = provider.request(.querySource("blog-pic", "", "10", "", ""))
        task.mapCodable(QuerySource.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(model)
                    print(String(data: data, encoding: .utf8))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testBatchSourceMetaInfo() throws {
        let task = provider.request(.batchFileMetaInfo("blog-pic", ["1111111111.png"]))
        task.mapCodable(QuerySource.self).whenComplete { (result) in
            switch result {
            case .success(let model):
                do {
                    let encoder = JSONEncoder()
                    let data = try encoder.encode(model)
                    print(String(data: data, encoding: .utf8))
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        try task.wait()
    }
    
    func testAuth() throws {
        let str = Base64FS.encodeString(str: "qiniuphotos:gogopher.jpg")
        print(str)
        let str1 = Base64FS.decodeString(str: "ZnNpemU9Ng==")
        print(str1)
        
        let test = 14408200048442046
        print(test)
        
    }
    
    
}
