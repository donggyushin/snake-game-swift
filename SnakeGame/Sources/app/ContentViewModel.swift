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
    @Injected(\.scoreRepository) var scoreRepository

    var currentScore: Int {
        snake.score()
    }

    @MainActor var tickInterval: TimeInterval {
        if snake.count >= 30 {
            return 0.1
        } else if snake.count >= 20 {
            return 0.2
        } else if snake.count >= 15 {
            return 0.3
        } else if snake.count >= 10 {
            return 0.4
        } else if snake.count >= 6 {
            return 0.6
        } else if snake.count >= 3 {
            return 0.8
        } else {
            return 1
        }
    }

    public init(grid: Double = 30) {
        self.grid = grid
    }

    @MainActor func set(_ direction: Direction) {
        guard !isGameOver else { return }
        guard snake.isEmpty == false else { return }
        var head = snake[0]
        head.direction = direction
        snake[0] = head
    }

    @MainActor func tick() {
        guard !isGameOver else { return }
        move()
    }

    @MainActor func generateInitialSnake() {
        snake = [
            .init(x: grid / 2, y: grid / 2)
        ]
        isGameOver = false
    }

    @MainActor private func move() {
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

        if Bool.random(), Bool.random(), Bool.random() {
            generateFoodToRandomCoordinate()
        }

        for s in snake {
            if ateFood(s) {
                removeFood(from: s)
                if let tail = snake.last {
                    appendTail(tail)
                }
            }
        }
    }

    @MainActor private func appendTail(_ tail: Square) {
        // if direction down, then append tail y -= 1

        let newTail: Square

        switch tail.direction {
        case .down:
            newTail = .init(x: tail.x, y: tail.y - 1, direction: tail.direction)
        case .up:
            newTail = .init(x: tail.x, y: tail.y + 1, direction: tail.direction)
        case .right:
            newTail = .init(x: tail.x - 1, y: tail.y, direction: tail.direction)
        case .left:
            newTail = .init(x: tail.x + 1, y: tail.y, direction: tail.direction)
        }

        snake.append(newTail)
    }

    @MainActor private func isConflict(_ square: Square) -> Bool {
        guard square.x >= 0, square.y >= 0 else { return true }
        guard square.x < grid, square.y < grid else { return true }

        // Check body conflict
        var keySet: Set<String> = []

        for s in snake {
            if keySet.contains(s.key) {
                return true
            } else {
                keySet.insert(s.key)
            }
        }

        return false
    }

    @MainActor private func generateFoodToRandomCoordinate() {
        while true {
            // Food, Square 가 없는 위치
            let x = availableCoordinateNumber.randomElement()!
            let y = availableCoordinateNumber.randomElement()!

            for square in snake {
                if square.x == x, square.y == y {
                    continue
                }
            }

            for food in foods {
                if food.x == x, food.y == y {
                    continue
                }
            }

            foods.append(.init(x: x, y: y))
            break
        }
    }

    @MainActor private func ateFood(_ square: Square) -> Bool {
        let x = square.x
        let y = square.y

        for food in foods {
            if food.x == x && food.y == y {
                return true
            }
        }

        return false
    }

    @MainActor private func removeFood(from square: Square) {
        let x = square.x
        let y = square.y

        for (index, food) in foods.enumerated() {
            if food.x == x, food.y == y {
                if foods.indices.contains(index) {
                    foods.remove(at: index)
                }
            }
        }
    }
}
