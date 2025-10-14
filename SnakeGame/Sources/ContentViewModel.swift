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

    @MainActor func move() {
        guard snake.isEmpty == false else { return }
        var prevDirection = snake[0].direction

        for i in snake.indices {
            var square = snake[i]

            switch square.direction {
            case .up:
                square.y -= 1
            case .down:
                square.y += 1
            case .left:
                square.x -= 1
            case .right:
                square.x += 1
            }

            let tempDirection = square.direction
            // 자기 앞 square 의 방향을 따라감
            square.direction = prevDirection
            prevDirection = tempDirection
            snake[i] = square
        }
    }

    @MainActor func set(_ direction: Direction) {
        snake[0].direction = direction
    }
}
