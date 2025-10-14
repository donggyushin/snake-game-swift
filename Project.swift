import ProjectDescription

let project = Project(
    name: "SnakeGame",
    targets: [
        .target(
            name: "SnakeGame",
            destinations: .macOS,
            product: .app,
            bundleId: "dev.tuist.SnakeGame",
            infoPlist: .default,
            buildableFolders: [
                "SnakeGame/Sources",
                "SnakeGame/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "SnakeGameTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "dev.tuist.SnakeGameTests",
            infoPlist: .default,
            buildableFolders: [
                "SnakeGame/Tests"
            ],
            dependencies: [.target(name: "SnakeGame")]
        ),
    ]
)
