// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyFoundation",
    products: [
        .library(
            name: "SwiftyViews",
            targets: ["SwiftyViews"]),
        .library(
            name: "SwiftyStorage",
            targets: ["SwiftyStorage"]),
        .library(
            name: "SwiftyNetworking",
            targets: ["SwiftyNetworking"]),
        .library(
            name: "SwiftyUtilities",
            targets: ["SwiftyUtilities"]),
        .library(
            name: "SwiftyNLP",
            targets: ["SwiftyNLP"]),
        .library(
            name: "SwiftyImageProcessing",
            targets: ["SwiftyImageProcessing"]),
        .library(
            name: "SwiftyEntities",
            targets: ["SwiftyEntities"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        .package(url: "https://github.com/launchdarkly/swift-eventsource", from: "3.0.0"),
        .package(url: "https://github.com/lorenzofiamingo/swiftui-cached-async-image", from: "2.0.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "SwiftyEntities",
            dependencies: [],
            path: "Sources/Entities"
        ),
        .target(
            name: "SwiftyImageProcessing",
            dependencies: [],
            path: "Sources/ImageProcessing"
        ),
        .target(
            name: "SwiftyNetworking",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "LDSwiftEventSource", package: "swift-eventsource"),
            ],
            path: "Sources/Networking"
        ),
        .target(
            name: "SwiftyNLP",
            dependencies: [],
            path: "Sources/NLP"
        ),
        .target(
            name: "SwiftyStorage",
            dependencies: [
                .product(name: "KeychainAccess", package: "keychainaccess"),
            ],
            path: "Sources/Storage"
        ),
        .target(
            name: "SwiftyUtilities",
            dependencies: [],
            path: "Sources/Utilities"
        ),
        .target(
            name: "SwiftyViews",
            dependencies: [
                .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image"),
            ],
            path: "Sources/Views"
        )
    ]
)
