// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LifeCalendar",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "LifeCalendar",
            targets: ["LifeCalendar"]),
    ],
    dependencies: [
        .package(url: "https://github.com/malcommac/SwiftDate", from: "7.0.0"),
        .package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "3.0.0")),
    ],
    targets: [
        .target(
            name: "LifeCalendar",
            dependencies: [
                .product(name: "SwiftDate", package: "SwiftDate"),
                .product(name: "Then", package: "Then")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "LifeCalendarTests",
            dependencies: ["LifeCalendar"]),
    ]
)
