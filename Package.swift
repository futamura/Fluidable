// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Fluidable",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Fluidable",
            targets: ["Fluidable"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "7.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "14.0.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.5.0"),
    ],
    targets: [
        .target(
            name: "Fluidable",
            path: "Sources",
            exclude: [
                "Fluidable.h",
                "Info.plist",
            ],
            swiftSettings: [
                .swiftLanguageMode(.v5),
            ]
        ),
        .testTarget(
            name: "FluidableTests",
            dependencies: [
                "Fluidable",
                .product(name: "Quick", package: "Quick"),
                .product(name: "Nimble", package: "Nimble"),
            ],
            path: "Tests",
            exclude: [
                "Info.plist",
            ],
            swiftSettings: [
                .swiftLanguageMode(.v5),
            ]
        ),
    ]
)
