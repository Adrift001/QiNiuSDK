//
//  ServiceTests.swift
//  QiNiuSDKTests
//
//  Created by 荆学涛 on 2019/8/17.
//

import XCTest
@testable import QiNiuSDK
@testable import Crypto
@testable import AsyncHTTPClient
@testable import NIOHTTP1
@testable import NIO

final class BucketTests: BaseTestCase {
        
    override func setUp() {
        super.setUp()
        let environment = ProcessInfo.processInfo.environment
        Keys.accessKey = environment["AK"] ?? ""
        Keys.secretKey = environment["SK"] ?? ""
    }
    
    let provider = Provider<BucketProvider>(plugins: [NetworkLoggerPlugin(verbose: true), AuthorizationPlugin()])
    
    func test001Buckets() throws {
        let expectation = self.expectation(description: "test001Buckets")
        let task = provider.request(.buckets)
        var buckets: [String] = []
        task.mapCodable([String].self).whenComplete { (result) in
            switch result {
            case .success(let arr):
                buckets = arr
                print(arr)
            case .failure(let err):
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssert(!buckets.isEmpty)
    }
    
    func test002BucketSpaceDomainName() throws {
        let expectation = self.expectation(description: "test002BucketSpaceDomainName")
        let task = provider.request(.bucketSpaceDomainName("blog-pic"))
        var domains: [String] = []
        task.mapCodable([String].self).whenComplete { (result) in
            switch result {
            case .success(let arr):
                domains = arr
            case .failure(let err):
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssert(!domains.isEmpty)
    }
    
    func test003CreateBucket() throws {
        let expectation = self.expectation(description: "test003CreateBucket")
        let task = provider.request(.createBucket("jingxuetao-hello", .z0))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let err):
                print(err)
                error = err
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        
        XCTAssertNil(error)
    }
    
    func test005SetBucketAccess() throws {
        let expectation = self.expectation(description: "test005SetBucketAccess")
        let task = provider.request(.setBucketAccess("jingxuetao-hello", .public))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
    }
    
    func test006SetBucketTags() throws {
        let expectation = self.expectation(description: "test006SetBucketTags")
        let task = provider.request(.setBucketTags("jingxuetao-hello", BucketTagsModel(Tags: [BucketTagModel(Key: "key1", Value: "value1")])))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
    }
    
    func test007QueryBucketTags() throws {
        let expectation = self.expectation(description: "test007QueryBucketTags")
        let task = provider.request(.queryBucketTags("jingxuetao-hello"))
        var error: Error?
        task.mapCodable(BucketTagsModel.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
    }
    
    func test008DeleteBucketTags() throws {
        let expectation = self.expectation(description: "test008DeleteBucketTags")
        let task = provider.request(.deleteBucketTags("jingxuetao-hello"))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
    }
    
    func test009UpdateFileStatus() throws {
        let expectation = self.expectation(description: "test009UpdateFileStatus")
        let task = provider.request(.updateFileStatus("blog-pic", "1111111111.png", .enable))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
        
    }
    
    func test101UpdateFileStoreType() throws {
        let expectation = self.expectation(description: "test101UpdateFileStoreType")
        let task = provider.request(.updateFileStoreType("blog-pic", "1.png", .low))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
        
    }
    
    func test011UpdateFileLife() throws {
        let expectation = self.expectation(description: "test011UpdateFileLife")
        let task = provider.request(.updateFileLife("blog-pic", "1.png", 100))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
        
    }
    
    func test012QueryFileMetaInfo() throws {
        let expectation = self.expectation(description: "test012QueryFileMetaInfo")
        let task = provider.request(.queryFileMetaInfo("blog-pic", "1.png"))
        var error: Error?
        task.mapCodable(FileInfo.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
        
    }
    
    func test013RenameFile() throws {
        let expectation = self.expectation(description: "test013RenameFile")
        let task = provider.request(.renameFile("blog-pic", "1.png", "blog-pic", "1111111111.png", true))
        var error: Error?
        task.mapCodable(FileInfo.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
        
    }
    
    func test014PrefetchFile() throws {
        let expectation = self.expectation(description: "test014PrefetchFile")
        let task = provider.request(.prefetchFile("blog-pic", "1111111111.png"))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
        
    }
    
    func test015UpdateMetaInfo() throws {
        let expectation = self.expectation(description: "test015UpdateMetaInfo")
        let metaInfo = ResourceMetaInfo(bucketName: "blog-pic", fileName: "11.jpg", mimeType: "image/jpeg", metaKey: "jpg_key", metaValue: "jpg_value", cond: ResourceMetaInfoCond(hash: "", mime: "image/jpeg", fsize: 0, putTime: ""))
        print(metaInfo.cond)
        let task = provider.request(.updateFileMetaInfo(metaInfo))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
        
    }
    
    func test016QuerySource() throws {
        let expectation = self.expectation(description: "test016QuerySource")
        let task = provider.request(.querySource("blog-pic", "", "10", "", ""))
        var error: Error?
        task.mapCodable(QuerySource.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
        
    }
    
    func test017BatchSourceMetaInfo() throws {
        let expectation = self.expectation(description: "test017BatchSourceMetaInfo")
        let task = provider.request(.batchFileMetaInfo([BatchModel(type: .stat, bucketName: "blog-pic", fileName: "11.jpg")]))
        var error: Error?
        task.mapCodable(QuerySource.self).whenComplete { (result) in
            switch result {
            case .success(_):
                break
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
    }
    
    func test004DeleteBucket() throws {
        let expectation = self.expectation(description: "test004DeleteBucket")
        let task = provider.request(.deleteBucket("jingxuetao-hello"))
        var error: Error?
        task.mapCodable(EmptyModel.self).whenComplete { (result) in
            switch result {
            case .success(let string):
                print(string)
            case .failure(let err):
                error = err
                print(err)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertNil(error)
    }
}

