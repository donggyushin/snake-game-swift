import Combine
import Foundation

final class LeftSideBarModel: ObservableObject {
    @Injected(\.scoreRepository) var scoreRepository

    @Published var scores: [Score] = []
    @Published var canSaveGame = true

    @MainActor func fetchScores() {
        scores = scoreRepository.get()
    }

    @MainActor func saveGame(value: Int, createdAt: Date, nickname: String) {
        canSaveGame = false

        let id = UUID().uuidString

        let score = Score(id: id, value: value, createdAt: createdAt, nickname: nickname)

        scoreRepository.post(score)
    }
}
