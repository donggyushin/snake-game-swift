import Combine
import Foundation

public final class ContentViewModel: ObservableObject {
    // Snake can go to x: grid - 1, y: grid - 1
    let grid: Double

    @Published var snake: [Square] = []

    public init(grid: Double = 30) {
        self.grid = grid
    }

    @MainActor func generateInitialSnake() {
        snake = [
            .init(x: grid / 2, y: grid / 2)
        ]
    }

    @MainActor func move(_ direction: Direction) {

        for i in snake.indices {
            var square = snake[i]

            switch direction {
            case .up:
                square.y -= 1
                print("up")
            case .down:
                square.y += 1
                print("down")
            case .left:
                square.x -= 1
                print("left")
            case .right:
                square.x += 1
                print("right")

            }
        }
    }
}
