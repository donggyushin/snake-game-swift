import Foundation

final class ScoreRepositoryUserDefaults: ScoreRepository {
    @UserDefaultsWrapper<[Score]>("score", []) var scores

    func post(_ score: Score) {
        var scores = get()
        scores.append(score)
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
