import Combine
import Foundation

final class LeftSideBarModel: ObservableObject {
    @Injected(\.scoreRepository) var scoreRepository

    @Published var scores: [Score] = []
    @Published var canSaveGame = true
    private var cancellables = Set<AnyCancellable>()

    @MainActor func fetchScores() {
        scores = scoreRepository.get()
    }

    @MainActor func saveGame(value: Int, createdAt: Date, nickname: String) {
        canSaveGame = false

        let id = UUID().uuidString

        let score = Score(id: id, value: value, createdAt: createdAt, nickname: nickname)

        scoreRepository.post(score)
        fetchScores()
    }

    @MainActor func deleteScore(_ score: Score) {
        scoreRepository.delete(score.id)

        if let index = scores.firstIndex(where: { item in
            score.id == item.id
        }) {
            scores.remove(at: index)
        }
    }
}
