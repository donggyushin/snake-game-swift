import Combine
import Foundation

public final class ContentViewModel: ObservableObject {
    @Published var snake: [Square] = [
        .init(x: 0, y: 0)
    ]
}
