import Foundation

class GameViewModel: ObservableObject {
    @Published var currentQuestion: Question?
    @Published var score = 0
    @Published var questionIndex = 0
    @Published var isGameActive = false
    @Published var gameHistory: [GameHistory] = []
    @Published var totalGames = 0
    @Published var selectedAnswer: String?
    @Published var showCorrectAnswer = false
    
    private let userDefaults = UserDefaults.standard
    private let gameHistoryKey = "gameHistory"
    private let totalGamesKey = "totalGames"
    
    private var allQuestions: [Question] = [
        Question(
            text: "Türkiye'nin başkenti neresidir?",
            options: ["İstanbul", "Ankara", "İzmir", "Bursa"],
            correctAnswer: "Ankara"
        ),
        Question(
            text: "Hangi gezegen Güneş Sistemi'nin en büyük gezegenidir?",
            options: ["Mars", "Venüs", "Jüpiter", "Satürn"],
            correctAnswer: "Jüpiter"
        ),
        Question(
            text: "İstanbul'un fethi hangi yılda gerçekleşmiştir?",
            options: ["1453", "1454", "1455", "1456"],
            correctAnswer: "1453"
        ),
        Question(
            text: "Hangi element periyodik tabloda 'Fe' sembolü ile gösterilir?",
            options: ["Flor", "Demir", "Fosfor", "Fermiyum"],
            correctAnswer: "Demir"
        ),
        Question(
            text: "Hangisi bir programlama dili değildir?",
            options: ["Python", "Java", "HTML", "Ruby"],
            correctAnswer: "HTML"
        ),
        Question(
            text: "Dünya'nın en büyük okyanusu hangisidir?",
            options: ["Atlas", "Hint", "Pasifik", "Arktik"],
            correctAnswer: "Pasifik"
        ),
        Question(
            text: "Hangi yıl Türkiye Cumhuriyeti kurulmuştur?",
            options: ["1920", "1921", "1922", "1923"],
            correctAnswer: "1923"
        ),
        Question(
            text: "DNA'nın açılımı nedir?",
            options: ["Deoksiribo Nükleik Asit", "Diribo Nükleik Asit", "Deoksiribo Nitrik Asit", "Diribo Nitrik Asit"],
            correctAnswer: "Deoksiribo Nükleik Asit"
        ),
        Question(
            text: "Hangi gezegen 'Kızıl Gezegen' olarak bilinir?",
            options: ["Venüs", "Mars", "Jüpiter", "Merkür"],
            correctAnswer: "Mars"
        ),
        Question(
            text: "Hangisi bir Nobel ödül kategorisi değildir?",
            options: ["Fizik", "Kimya", "Matematik", "Edebiyat"],
            correctAnswer: "Matematik"
        )
    ]
    
    private var questions: [Question] = []
    
    init() {
        loadGameHistory()
        totalGames = userDefaults.integer(forKey: totalGamesKey)
    }
    
    private func loadGameHistory() {
        if let data = userDefaults.data(forKey: gameHistoryKey),
           let history = try? JSONDecoder().decode([GameHistory].self, from: data) {
            gameHistory = history
        }
    }
    
    private func saveGameHistory() {
        if let encoded = try? JSONEncoder().encode(gameHistory) {
            userDefaults.set(encoded, forKey: gameHistoryKey)
        }
        userDefaults.set(totalGames, forKey: totalGamesKey)
    }
    
    var averageScore: Double {
        guard !gameHistory.isEmpty else { return 0 }
        let total = gameHistory.reduce(0) { $0 + $1.score }
        return Double(total) / Double(gameHistory.count)
    }
    
    func startGame() {
        score = 0
        questionIndex = 0
        isGameActive = true
        totalGames += 1
        
        // Tüm soruları karıştır ve ilk 10'unu al
        questions = allQuestions.shuffled()
        
        // Her sorunun şıklarını karıştır
        questions = questions.map { question in
            let shuffledOptions = question.options.shuffled()
            return Question(
                text: question.text,
                options: shuffledOptions,
                correctAnswer: question.correctAnswer
            )
        }
        
        loadNextQuestion()
    }
    
    func endGame() {
        let newGame = GameHistory(score: score, date: Date(), gameNumber: totalGames)
        gameHistory.append(newGame)
        saveGameHistory()
    }
    
    func loadNextQuestion() {
        if questionIndex < questions.count {
            currentQuestion = questions[questionIndex]
        } else {
            isGameActive = false
            endGame()
        }
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        guard let currentQuestion = currentQuestion else { return false }
        selectedAnswer = answer
        showCorrectAnswer = true
        let isCorrect = answer == currentQuestion.correctAnswer
        
        if isCorrect {
            score += 10
            // Doğru cevapta 0.5 saniye bekle
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.selectedAnswer = nil
                self.showCorrectAnswer = false
                self.questionIndex += 1
                self.loadNextQuestion()
            }
        } else {
            // Yanlış cevapta 1 saniye bekle
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.selectedAnswer = nil
                self.showCorrectAnswer = false
                self.questionIndex += 1
                self.loadNextQuestion()
            }
        }
        
        return isCorrect
    }
    
    func resetGame() {
        score = 0
        questionIndex = 0
        isGameActive = false
        currentQuestion = nil
    }
    
    func cancelGame() {
        score = 0
        questionIndex = 0
        isGameActive = false
        currentQuestion = nil
        selectedAnswer = nil
        showCorrectAnswer = false
        totalGames -= 1
    }
} 