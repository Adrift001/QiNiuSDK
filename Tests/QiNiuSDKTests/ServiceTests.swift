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

final class ServiceTests: XCTestCase {
    let timeout: TimeInterval = 5
    override func setUp() {
        super.setUp()
        
    }
    
    func testBuckets() throws {
        let provider = Provider<QiNiuProvider>()
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
//        ["blog-video", "blog-music", "blog-pic", "blog"]
        let provider = Provider<QiNiuProvider>()
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
        let provider = Provider<QiNiuProvider>()
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
        let provider = Provider<QiNiuProvider>()
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
        let provider = Provider<QiNiuProvider>()
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
        let provider = Provider<QiNiuProvider>()
        
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
    
    
}
