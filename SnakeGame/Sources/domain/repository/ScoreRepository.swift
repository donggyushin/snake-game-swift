import Foundation

protocol ScoreRepository {
    func post(_ score: Score)
    func get() -> [Score]
    func delete(_ id: String)
}
