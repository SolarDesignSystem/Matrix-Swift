// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Matrix",
    products: [
        .library(name: "Matrix", targets: ["Matrix"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.2"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(name: "Matrix", dependencies: [
            .product(name: "Numerics", package: "swift-numerics"),
        ]),
        .testTarget(name: "MatrixTests", dependencies: ["Matrix"]),
    ]
)
