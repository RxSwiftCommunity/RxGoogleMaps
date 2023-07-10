// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "RxGoogleMaps",
  products: [
    .library(name: "RxGoogleMaps", targets: ["RxGoogleMaps"]),
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.6.0")),
    .package(url: "https://github.com/gomore/GoogleMaps-SPM.git", .upToNextMajor(from: "7.3.0")),
  ],
  targets: [
    .target(name: "RxGoogleMaps", dependencies: ["RxSwift", "RxCocoa", "GoogleMaps", "GoogleMapsCore", "GoogleMapsBase"]),
  ]
)