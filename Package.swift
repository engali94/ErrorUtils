// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ErrorUtils",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "ErrorUtils",
            targets: ["ErrorUtils"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ErrorUtils",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "ErrorUtilsTests",
            dependencies: ["ErrorUtils"],
            path: "Tests"
        ),
    ]
)
