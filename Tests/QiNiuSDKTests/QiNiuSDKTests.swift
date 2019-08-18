import XCTest
@testable import QiNiuSDK

final class QiNiuSDKTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }
    
    func testUploadToken() {
        let auth = Auth.create()
        let token = auth.uploadToken(bucket: "picture")
        print(token)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
