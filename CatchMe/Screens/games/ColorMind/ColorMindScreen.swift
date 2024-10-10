import SwiftUI

struct ColorMindScreen: View {
    
    @State var buttonColors: [Color] = Array(repeating: .clear, count: 16)
    @State var changedColors: [Color] = Array(repeating: .blue, count: 16)
    @State var isFirstButtonPressed = false
    @State var isSecondButtonPressed = false
    @State var firstButtonIndex = 0
    @State var secondButtonIndex = 0
    @State var score = 0
    @State var whiteColorCounter = 0
    @State var buttonsDisabled = false
    
    @State var highscore_mind = UserDefaults.standard.integer(forKey: "highscore_mind")
    @State private var showAlert = false
    @State private var showAnotherView = false
    
    let colors: [Color] = [.red, .orange, .green, .yellow, .purple, .black, .gray, .brown]
    var current_color : Color = .blue
    var body: some View {

            VStack{
                
                Text("Highscore: \(highscore_mind)")
                    .padding(20)
                    .font(.largeTitle)
                Text("Point: \(score)")
                    .padding(.bottom ,30)
                    .font(.largeTitle)
                VStack(spacing: 10) {
                    
                    ForEach((0..<4), id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach((0..<4), id: \.self) { col in
                                
                                let index = row * 4 + col
                                Button(action: {
                                    if changedColors[index] != .white && !buttonsDisabled{
                                        if isFirstButtonPressed && firstButtonIndex == index {
                                            return // Ignore the press if the same button is clicked twice
                                        }
                                        
                                        print("\(buttonColors[index])")
                                        changedColors[index] = buttonColors[index]
                                        if (isFirstButtonPressed == false)
                                        {
                                            
                                            isFirstButtonPressed = true
                                            firstButtonIndex = index
                                            
                                        }else if(isSecondButtonPressed == false)
                                        {
                                            secondButtonIndex = index
                                            isSecondButtonPressed = true
                                            buttonsDisabled = true
                                            sendButtonIndex(index1: firstButtonIndex, index2: secondButtonIndex)
                                            
                                        }
                                    }
                                }) {
                                    Text(" ")
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                .frame(width: 80 ,height: 80)
                                .background(changedColors[index])
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .contentShape(Rectangle())
                            }
                        }
                    }
                }
                Button( action:
                {
                    updateHighScore()
                    randomColorGenerator()
                    changedColors = Array(repeating: .blue, count: 16)
                    score = 0
                    
                }){
                    Text("Restart")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.largeTitle)
                }.frame(width: UIScreen.main.bounds.width * 0.8, height: 80)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .contentShape(Rectangle())
                    .padding()
                
            }
            .onAppear {
                highscore_mind = UserDefaults.standard.integer(forKey: "highscore_mind")
                randomColorGenerator()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Game Over"),
                    message: Text("Your final score is \(score). High score: \(highscore_mind)"),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
    
    func updateHighScore()
    {
        if score >= highscore_mind
        {
            highscore_mind = score
            UserDefaults.standard.set(highscore_mind, forKey: "highscore_mind")
        }
    }
    
    func randomColorGenerator()
    {
        let numberOfColors = colors.count
        let repetitions = buttonColors.count / numberOfColors
        let colorArray = Array(repeating: colors, count: repetitions).flatMap { $0 }.shuffled()
        buttonColors = colorArray
    }
    
    func checkButtons(colorlist: [Color?]) {
        whiteColorCounter = 0
        let number = colorlist.count
        
        for index in 0..<number {
            if colorlist[index] == .white {
                whiteColorCounter += 1
            }
        }
        print(whiteColorCounter)
        if whiteColorCounter == 16{
            showAlert = true
        }
        
    }
    
    func sendButtonIndex(index1: Int, index2: Int)
    {
        
        print("\(index1) && \(index2) pressed")
        if(buttonColors[index1] == buttonColors[index2])
        {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                changedColors[index1] = .white
                changedColors[index2] = .white
                checkButtons(colorlist: changedColors)
                score = score + 10
                buttonsDisabled = false
                updateHighScore()
            }
        }
        else
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                changedColors[index1] = .blue
                changedColors[index2] = .blue
                checkButtons(colorlist: changedColors)
                score = score - 2
                buttonsDisabled = false
                updateHighScore()
            }
        }
        
        
        isFirstButtonPressed = false
        isSecondButtonPressed = false
        
        
    }
    
}

#Preview {
    ColorMindScreen()
}
