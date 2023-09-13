// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [
        .macOS(.v12),
    ],
    dependencies: [
        .package(url: "https://github.com/yonaskolb/Mint.git", exact: .init(stringLiteral: "0.17.2")),
    ],
    targets: [
        .target(name: "Common", path: ""),
    ]
)
