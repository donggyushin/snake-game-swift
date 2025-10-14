import Combine
import Foundation

public final class ContentViewModel: ObservableObject {
    @Published var snake: [Square] = [
        .init(x: 0, y: 0),
        .init(x: 29, y: 29),
    ]
}
