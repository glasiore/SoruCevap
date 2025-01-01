import SwiftUI

struct QuestionView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Soru \(viewModel.questionIndex + 1)/10")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Button(action: {
                    viewModel.cancelGame()
                    dismiss()
                }) {
                    Text("Oyunu Bitir")
                        .foregroundColor(.red)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.red, lineWidth: 1)
                        )
                }
            }
            
            if let question = viewModel.currentQuestion {
                Text(question.text)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                
                ForEach(question.options, id: \.self) { option in
                    Button(action: {
                        viewModel.checkAnswer(option)
                    }) {
                        Text(option)
                            .font(.body)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                Group {
                                    if viewModel.showCorrectAnswer {
                                        if option == question.correctAnswer {
                                            Color.green // Doğru cevap her zaman yeşil
                                        } else if option == viewModel.selectedAnswer {
                                            Color.red // Seçilen yanlış cevap kırmızı
                                        } else {
                                            Color.blue // Diğer seçenekler mavi
                                        }
                                    } else {
                                        Color.blue // Normal durumda mavi
                                    }
                                }
                            )
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.showCorrectAnswer) // Cevap gösterilirken butonları devre dışı bırak
                }
            }
            
            Text("Skor: \(viewModel.score)")
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding()
        .navigationTitle("Bilgi Yarışması")
    }
} 