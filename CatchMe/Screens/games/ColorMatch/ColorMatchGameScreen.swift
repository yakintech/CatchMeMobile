import Foundation
import SwiftUI

struct ColorMatchGameScreen: View {
    // Oyun Durumları
    
    enum gameStatus {
        case initial,
        started,
        ended
    }
        @State private var score = 0
        @State private var highestScore = 0
        @State private var currentColor = ""
        @State private var colorText = ""
        @State private var currentGameStatus = gameStatus.initial
        @State private var remainingTime = 3
        
        // Renkler
        let colors: [String: Color] = [
            "RED": .red,
            "GREEN": .green,
            "BLUE": .blue,
            "YELLOW": .yellow,
            "PURPLE": .purple,
            "ORANGE": .orange
        ]
        
        // Zamanlayıcı
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        var body: some View {
            VStack {
                if currentGameStatus == gameStatus.initial {
                    Text("Color Match Oyununa Hoşgeldin!")
                        .font(.largeTitle)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Text("En Yüksek Puan: \(highestScore)")
                        .font(.title2)
                        .padding()
                    
                    Button(action: resetGame) {
                        Text("Oyuna Başla")
                            .font(.title3)
                            .bold()
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                else if currentGameStatus == gameStatus.ended  {
                    Text("Oyun Bitti! Puanınız: \(score)")
                        .font(.largeTitle)
                        .padding()
                    
                    Text("En Yüksek Puan: \(highestScore)")
                        .font(.title2)
                        .padding()
                    
                    Button(action: resetGame) {
                        Text("Yeniden Başla")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    Text(colorText)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(colors[currentColor] ?? .black)
                        .padding()
                    
                    HStack {
                        Button(action: {
                            checkAnswer(true)
                        }) {
                            Text("TRUE")
                                .font(.title3)
                                .bold()
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Button(action: {
                            checkAnswer(false)
                        }) {
                            Text("FALSE")
                                .font(.title3)
                                .bold()
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    Text("Kalan Süre: \(remainingTime) saniye")
                        .font(.title3)
                        .padding()
                        .onReceive(timer) { _ in
                            if remainingTime > 0 {
                                remainingTime -= 1
                            } else {
                                gameOver()
                            }
                        }
                    
                    Text("Puan: \(score)")
                        .font(.title)
                }
            }
            .onAppear(perform: startNewRound)
            .onAppear(perform: {
                highestScore = UserDefaults.standard.integer(forKey: "HighestScore");
            })
        }
        
        func startNewRound() {
            remainingTime = 3
            currentColor = colors.keys.randomElement()!
            colorText = colors.keys.randomElement()!
        }
        
        func checkAnswer(_ isTrue: Bool) {
            let isCorrect = (currentColor == colorText)
            if (isCorrect && isTrue) || (!isCorrect && !isTrue) {
                score += 5
                if score > highestScore {
                    highestScore = score
                    UserDefaults.standard.set(highestScore, forKey: "HighestScore")
                }
                startNewRound()
            } else {
                gameOver()
            }
        }
        
        func gameOver() {
            currentGameStatus = gameStatus.ended
        }
        
        func resetGame() {
            score = 0
            currentGameStatus = gameStatus.started
            startNewRound()
        }
}

#Preview {
    ColorMatchGameScreen()
}

