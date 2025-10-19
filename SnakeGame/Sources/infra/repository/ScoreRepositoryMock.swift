import Foundation

final class ScoreRepositoryMock: ScoreRepository {
    var scores: [Score] = [
        .init(id: "1", value: 5580, createdAt: Date() - 18000),
        .init(id: "2", value: 4230, createdAt: Date() - 17000),
        .init(id: "3", value: 3580, createdAt: Date() - 15000),
        .init(id: "4", value: 1580, createdAt: Date() - 28000),
        .init(id: "5", value: 580, createdAt: Date() - 18730)
    ]

    func post(_ score: Score) {
        var scores = scores
        scores.append(score)
        scores.sort { $0.value > $1.value }
        self.scores = scores
    }

    func get() -> [Score] {
        scores
    }

    func delete(_ id: String) {
        var scores = scores
        scores = scores.filter { $0.id != id }
        self.scores = scores
    }
}
