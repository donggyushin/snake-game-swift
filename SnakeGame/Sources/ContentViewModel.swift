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
}
