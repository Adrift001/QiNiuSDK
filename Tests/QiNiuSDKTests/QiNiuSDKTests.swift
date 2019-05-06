import XCTest
@testable import QiNiuSDK

final class QiNiuSDKTests: XCTestCase {
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }
    
    func testUploadToken() {
        let auth = Auth.create(accessKey: "xxx", secretKey: "xxx")
        let token = auth.uploadToken(bucket: "picture")
        print(token)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}