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
    let host = "https://rs.qbox.me/buckets"
    override func setUp() {
        super.setUp()
    }

    //    ak: d05f31DhWMuCdnqYLmEHOFc5cMJ4rQ5dpnPJGB4F
    //    sk: q6l7YgfxOAVGSR8U5_DwButyC5133_urgBGyjIHt
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }
    
    func testSign() {
        let signingStr = "/buckets\n"
        do {
            // 参考:http://m.hangge.com/news/cache/detail_1867.html
            let sign = try HMAC(key: Keys.secretKey.bytes, variant: .sha1).authenticate(signingStr.bytes)
            let encodedSign = String(bytes: Base64FS.encode(data: sign), encoding: .utf8) ?? ""
            let accessToken = "\(Keys.accessKey):\(encodedSign)"
            print(accessToken)
        } catch {
        }
    }
    
    func send(_ httpClient: HTTPClient) {
        do {
            var request = try HTTPClient.Request(url: host, method: .GET)
            request.headers.add(name: "Authorization", value: "QBox d05f31DhWMuCdnqYLmEHOFc5cMJ4rQ5dpnPJGB4F:nEcq2-D6GhLBPz11cUVD-zTZCE4=")
            
            httpClient.execute(request: request).whenComplete { result in
                switch result {
                case .failure(let error):
                    // process error
                    print(error)
                case .success(let response):
                    if response.status == .ok {
                        // handle response
                        print(response.status)
                        
                        if var body = response.body {
                            let string = body.readString(length: body.readableBytes) ?? ""
                            let decoder = JSONDecoder()
                            do {
                                let array = try decoder.decode([String].self, from: string.data(using: .utf8)!)
                                print(array)
                            } catch {
                                print(error)
                            }
                        }
                    } else {
                        // handle remote error
                        print(response.status)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func testService() {
        let httpClient = HTTPClient(eventLoopGroupProvider: .shared(MultiThreadedEventLoopGroup(numberOfThreads: 10)))
        
//        for _ in 0...2000 {
            send(httpClient)
//        }
        
        defer {
            try? httpClient.syncShutdown()
        }
        RunLoop.main.run()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
