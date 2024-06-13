// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SoundpipeAudioKit",
    platforms: [.macOS(.v12), .iOS(.v13), .tvOS(.v13)],
    products: [.library(name: "SoundpipeAudioKit", targets: ["SoundpipeAudioKit"])],
    dependencies: [
        .package(url: "https://github.com/CharbelBL/KissFFT", from: "1.0.0"),
        .package(url: "https://github.com/CharbelBL/AudioKit", from: "5.6.0"),
        .package(url: "https://github.com/CharbelBL/AudioKitEX", from: "5.5.0"),
    ],
    targets: [
        .target(name: "Soundpipe",
                dependencies: ["KissFFT"],
                exclude: ["lib/inih/LICENSE.txt"],
                cSettings: [
                    .headerSearchPath("lib/inih"),
                    .headerSearchPath("Sources/soundpipe/lib/inih"),
                    .headerSearchPath("modules"),
                    .headerSearchPath("external"),
                ]),
        .target(name: "SoundpipeAudioKit", dependencies: ["AudioKit", "AudioKitEX", "CSoundpipeAudioKit"]),
        .target(name: "CSoundpipeAudioKit", dependencies: ["AudioKit", "AudioKitEX", "Soundpipe"]),
        .testTarget(name: "SoundpipeAudioKitTests", dependencies: ["SoundpipeAudioKit"], resources: [.copy("TestResources/")]),
        .testTarget(name: "CSoundpipeAudioKitTests", dependencies: ["CSoundpipeAudioKit"]),
    ],
    cxxLanguageStandard: .cxx14
)
