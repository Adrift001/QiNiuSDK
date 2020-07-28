//
//  File.swift
//  
//
//  Created by swifter on 2020/7/27.
//

import XCTest
@testable import QiNiuSDK
@testable import Crypto
@testable import AsyncHTTPClient
@testable import NIOHTTP1
@testable import NIO

class QiNiuSDK2Tests: BaseTestCase {
    
    let client = HTTPClient(eventLoopGroupProvider: .createNew)
    
    override func setUp() {
        super.setUp()
        let environment = ProcessInfo.processInfo.environment
        Keys.accessKey = environment["AK"] ?? ""
        Keys.secretKey = environment["SK"] ?? ""
    }
    
    
    func test1Buckets() {
        let expectation = self.expectation(description: "test001Buckets")
        let manager = BucketManager(client: client)
        var buckets: [String] = []
        manager.buckets { (result) in
            switch result {
            case .success(let arr):
                buckets = arr
            case .failure(let error):
                print(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssert(!buckets.isEmpty)
    }
    
}
