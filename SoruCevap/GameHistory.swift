import Foundation

struct GameHistory: Identifiable, Codable {
    let id = UUID()
    let score: Int
    let date: Date
    let gameNumber: Int
} 