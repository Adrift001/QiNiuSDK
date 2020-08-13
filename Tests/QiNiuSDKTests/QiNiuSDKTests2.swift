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
        try app.qiniu.buckets()
    }
    
    func testCreateBucket() throws {
        try app.qiniu.createBucket(bucketName: "jingxuetao-hello", region: Region.z0)
    }
    
    func testDomainList() throws {
        try app.qiniu.domainList(bucketName: "jingxuetao-hello")
    }
    
    func testStat() throws {
        try app.qiniu.stat(bucketName: "jingxuetao-hello", fileKey: "11222.jpg")
    }
    
    override func tearDown() {
        super.tearDown()
        app.shutdown()
    }
    
}
