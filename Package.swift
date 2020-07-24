// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QiNiuSDK",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "QiNiuSDK",
            targets: ["QiNiuSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.1.1"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "1.0.2"),
    ],
    targets: [
        .target(
            name: "QiNiuSDK",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "Crypto", package: "swift-crypto"),
            ]),
        .testTarget(
            name: "QiNiuSDKTests",
            dependencies: ["QiNiuSDK"]),
    ]
)

