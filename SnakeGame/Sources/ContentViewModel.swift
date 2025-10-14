import Combine
import Foundation

public final class ContentViewModel: ObservableObject {
    // Snake can go to x: grid - 1, y: grid - 1
    let grid: Double

    lazy var availableCoordinateNumber: [Double] = {
        var array: [Double] = []

        var i = 0.0
        while i < grid {
            array.append(i)
            i += 1
        }
        return array
    }()

    @Published var snake: [Square] = []
    @Published var foods: [Food] = []
    @Published var isGameOver = false

    public init(grid: Double = 30) {
        self.grid = grid
    }

    @MainActor func isConflict(_ square: Square) -> Bool {

        guard square.x >= 0, square.y >= 0 else { return true }
        guard square.x < grid, square.y < grid else { return true }

        return false
    }

    @MainActor func generateInitialSnake() {
        snake = [
            .init(x: grid / 2, y: grid / 2)
        ]
    }

    @MainActor func move() {
        guard !isGameOver else { return }
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

            guard !isConflict(square) else {
                isGameOver = true
                print("GameOver! \(square)")
                return
            }
            prevDirection = tempDirection
            snake[i] = square
        }

        if Bool.random() && Bool.random() && Bool.random() {
            generateFoodToRandomCoordinate()
        }
    }

    @MainActor func set(_ direction: Direction) {
        guard !isGameOver else { return }
        guard snake.isEmpty == false else { return }
        snake[0].direction = direction
    }

    @MainActor func generateFoodToRandomCoordinate() {
        while true {

            // Food, Square 가 없는 위치
            let x = availableCoordinateNumber.randomElement()!
            let y = availableCoordinateNumber.randomElement()!

            for square in snake {
                if square.x == x && square.y == y {
                    print("square 랑 위치 겹침")
                    continue
                }
            }

            for food in foods {

                if food.x == x && food.y == y {
                    print("Food 랑 위치 겹침")
                    continue
                }
            }

            self.foods.append(.init(x: x, y: y))
            break
        }
    }
}
