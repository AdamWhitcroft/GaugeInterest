import PackageDescription

let package = Package(
    name: "GaugeInterest",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "GaugeInterest",
            targets: ["GaugeInterest"]),
    ],
    targets: [
        .target(
            name: "GaugeInterest",
            dependencies: []),
        .testTarget(
            name: "GaugeInterestTests",
            dependencies: ["GaugeInterest"]),
    ]
)
