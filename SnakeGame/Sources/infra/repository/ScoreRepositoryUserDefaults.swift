import Foundation

final class ScoreRepositoryUserDefaults: ScoreRepository {
    @UserDefaultsWrapper<[Score]>("score", []) var scores

    func post(_ score: Score) {
        var scores = get()
        scores.append(score)
        scores.sort { $0.value > $1.value }
        self.scores = scores
    }

    func get() -> [Score] {
        return scores
    }

    func delete(_ id: String) {
        var scores = get()
        scores = scores.filter { $0.id != id }
        self.scores = scores
    }
}
