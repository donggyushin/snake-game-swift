import Combine

final class LeftSideBarModel: ObservableObject {
    @Injected(\.scoreRepository) var scoreRepository

    @Published var scores: [Score] = []

    @MainActor func fetchScores() {
        scores = scoreRepository.get()
    }
}
