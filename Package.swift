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
        .package(url: "https://github.com/vapor/vapor.git", from: "4.27.1")
    ],
    targets: [
        .target(
            name: "QiNiuSDK",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
            ]),
        .testTarget(
            name: "QiNiuSDKTests",
            dependencies: ["QiNiuSDK"]),
    ]
)

