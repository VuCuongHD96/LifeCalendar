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
        // Add the package dependency here
        .package(url: "https://github.com/malcommac/SwiftDate", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "LifeCalendar",
            dependencies: [
                // Link the dependency to your target
                .product(name: "SwiftDate", package: "SwiftDate")
            ]
        ),
        .testTarget(
            name: "LifeCalendarTests",
            dependencies: ["LifeCalendar"]),
    ]
)
