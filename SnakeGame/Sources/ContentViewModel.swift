import Combine
import Foundation

public final class ContentViewModel: ObservableObject {

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
