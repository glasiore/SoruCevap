import Foundation

struct Question: Identifiable, Codable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctAnswer: String
}

struct QuestionsResponse: Codable {
    let questions: [Question]
} 