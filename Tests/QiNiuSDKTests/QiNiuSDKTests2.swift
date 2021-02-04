//
//  File.swift
//  
//
//  Created by swifter on 2020/7/31.
//

import XCTest
@testable import Vapor
@testable import QiNiuSDK

final class BucketTests1: BaseTestCase {
    
    var env: Environment!
    var app: Application!
    
    override func setUp() {
        super.setUp()
        let environment = ProcessInfo.processInfo.environment
        Keys.accessKey = environment["AK"] ?? ""
        Keys.secretKey = environment["SK"] ?? ""
        env = try! Environment.detect()
        try! LoggingSystem.bootstrap(from: &env)
        app = Application(env)
    }
    
    func testPath() {
        let uri = URI(string: "https://www.baidu.com/hello")
        let result = uri.appendingPathComponent("world")
        print(result.path)
    }
    
    func testBuckets() throws {
        let model = try app.qiniu.buckets()
        print(model.toString())
    }
    
    func testCreateBucket() throws {
        let model = try app.qiniu.createBucket(bucketName: "jingxuetao-hello4", region: Region.z0)
        print(model.toString())
    }
    
    func testDeleteBucket() throws {
        let model = try app.qiniu.deleteBucket(bucketName: "jingxuetao-hello4")
        print(model.toString())
    }
    
    func testDomainList() throws {
        let model = try app.qiniu.domainList(bucketName: "blog-pic")
        print(model.toString())
    }
    
    func testStat() throws {
        let model = try app.qiniu.stat(bucketName: "jingxuetao-hello", fileKey: "11222.jpg")
        print(model.toString())
    }
    
    override func tearDown() {
        super.tearDown()
        app.shutdown()
    }
    
}
