// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxGoogleMaps",
    platforms: [.iOS(.v10)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RxGoogleMaps",
            targets: ["RxGoogleMaps"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sk-chanch/GoogleMaps-SPM", branch: "main"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMinor(from: "6.5.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RxGoogleMaps",
            dependencies: [
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "GoogleMaps", package: "GoogleMaps-SPM")
                
            ],
            path: "Sources"
        ),
    ]
)
