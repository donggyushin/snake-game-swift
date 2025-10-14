import Combine
import Foundation

public final class ContentViewModel: ObservableObject {

    let grid: Double

    @Published var snake: [Square] = [
        .init(x: 0, y: 0),
        .init(x: 29, y: 29),
    ]

    public init(grid: Double = 30) {
        self.grid = grid
    }
}
