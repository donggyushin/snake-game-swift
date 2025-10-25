import Foundation

struct Score: Codable, Identifiable {
    let id: String
    let value: Int
    let createdAt: Date
    let nickname: String
}
