//
//  ContentView.swift
//  SoruCevap
//
//  Created by EMRE GÜÇLÜ on 1.01.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameViewModel = GameViewModel()
    
    var body: some View {
        NavigationStack {
            if gameViewModel.isGameActive {
                QuestionView(viewModel: gameViewModel)
            } else if gameViewModel.questionIndex >= 10 {
                ScoreView(viewModel: gameViewModel)
            } else {
                VStack(spacing: 20) {
                    Text("Bilgi Yarışması")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    
                    Button(action: {
                        gameViewModel.startGame()
                    }) {
                        Text("Oyunu Başlat")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: ProfileView(viewModel: gameViewModel)) {
                        Text("Profil")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        Text("Ayarlar")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
