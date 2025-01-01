import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: GameViewModel
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Ortalama Puan
                VStack {
                    Text("Ortalama Puanınız")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text(String(format: "%.1f", viewModel.averageScore))
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.blue)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                
                // Oyun Geçmişi
                VStack(alignment: .leading, spacing: 15) {
                    Text("Oyun Geçmişi")
                        .font(.title2)
                        .foregroundColor(.blue)
                    
                    ForEach(viewModel.gameHistory.sorted(by: { $0.date > $1.date })) { game in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Oyun #\(game.gameNumber)")
                                    .font(.headline)
                                Text(dateFormatter.string(from: game.date))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text("\(game.score) Puan")
                                .font(.title3)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.05))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Profil")
    }
} 