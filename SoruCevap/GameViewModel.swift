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
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let userDefaults = UserDefaults.standard
    private let gameHistoryKey = "gameHistory"
    private let totalGamesKey = "totalGames"
    
    private let questionsURL = "https://raw.githubusercontent.com/KULLANICI_ADINIZ/REPO_ADINIZ/main/questions.json"
    private var allQuestions: [Question] = []
    
    init() {
        loadGameHistory()
        totalGames = userDefaults.integer(forKey: totalGamesKey)
        fetchQuestions()
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
    
    private func fetchQuestions() {
        isLoading = true
        guard let url = URL(string: questionsURL) else {
            errorMessage = "Geçersiz URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Hata: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "Veri alınamadı"
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(QuestionsResponse.self, from: data)
                    self?.allQuestions = response.questions
                } catch {
                    self?.errorMessage = "JSON çözümlenemedi: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
} 