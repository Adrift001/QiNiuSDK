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
    
    func testBuckets() throws {
        try app.qiniu.buckets()
    }
    
    override func tearDown() {
        super.tearDown()
        app.shutdown()
    }
    
}
