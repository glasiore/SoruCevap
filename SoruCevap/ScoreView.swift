import SwiftUI

struct ScoreView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Oyun Bitti!")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            Text("Toplam Skorunuz:")
                .font(.title)
            
            Text("\(viewModel.score)")
                .font(.system(size: 70, weight: .bold))
                .foregroundColor(.blue)
            
            Button(action: {
                viewModel.startGame()
            }) {
                Text("Yeniden Oyna")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                viewModel.resetGame()
                dismiss()
            }) {
                Text("Ana Sayfaya Dön")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sonuç")
    }
} 