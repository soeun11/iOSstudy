// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BoxOffices",
    
    ///iphone15 이상 지원
    platforms: [.iOS(.v15), .macOS(.v12)],
    
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BoxOffices",
            targets: ["BoxOffices"]
        ),
        /// 실행파일
        //.executable(name: <#T##String#>, targets: <#T##[String]#>)
    ],
    ///의존성정의
    /*
     dependency: [
         .package(url: <#T##String#>, from: <#T##Version#>)
         ],
     */
    /// 타겟추가
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "BoxOffices"
        ),
        .testTarget(
            name: "BoxOfficesTests",
            dependencies: ["BoxOffices"]
        ),
    ]
)
