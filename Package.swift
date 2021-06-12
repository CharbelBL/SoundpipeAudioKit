// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SoundpipeAudioKit",
    platforms: [.macOS(.v10_13), .iOS(.v11), .tvOS(.v11)],
    products: [.library(name: "SoundpipeAudioKit", targets: ["SoundpipeAudioKit"])],
    dependencies: [
        .package(url: "https://github.com/AudioKit/KissFFT", from: "1.0.0"),
        .package(url: "https://github.com/AudioKit/AudioKit", .branch("develop")),
    ],
    targets: [
        .target(name: "Soundpipe",
                dependencies: ["KissFFT"],
                exclude: ["lib/inih/LICENSE.txt"],
                cSettings: [
                    .headerSearchPath("lib/inih"),
                    .headerSearchPath("Sources/soundpipe/lib/inih"),
                    .headerSearchPath("modules"),
                    .headerSearchPath("external")
                ]),
        .target(name: "SoundpipeAudioKit", dependencies: ["AudioKit", "CSoundpipeAudioKit"]),
        .target(name: "CSoundpipeAudioKit", dependencies: ["AudioKit",  "Soundpipe"]),
        .testTarget(name: "SoundpipeAudioKitTests", dependencies: ["SoundpipeAudioKit"], resources: [.copy("TestResources/")]),
        .testTarget(name: "CSoundpipeAudioKitTests", dependencies: ["CSoundpipeAudioKit"]),
    ],
    cxxLanguageStandard: .cxx14
)
