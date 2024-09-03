//
//  QuestionScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI
import Alamofire

struct QuestionScreen: View {
    
    var quizId: String
    @State var quizDetail: [QuizDetail] = []
    @State var questionNumber: Int = 0
    @State var selectedAnswerId: String? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Sayfayı kapatmak için
    
    var body: some View {
        VStack(spacing: 20) {
            if quizDetail.count > 0 {
                // Soru başlığı
                Text(quizDetail[questionNumber].question.title)
                    .font(.headline)
                    .padding()
                    .multilineTextAlignment(.center)
                
                
                
                // Cevap şıkları
                ForEach(quizDetail[questionNumber].answers, id: \._id) { item in
                    AnswerOptionView(content: item.content, isSelected: selectedAnswerId == item._id)
                        .onTapGesture {
                            selectedAnswerId = item._id
                        }
                        .padding(.horizontal)
                }
                
                Spacer()
                
                // Butonlar
                HStack {
                    Spacer()
                    
                    // Eğer son sorudaysa
                    if questionNumber == quizDetail.count - 1 {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // quiz ekranına dön
                        }) {
                            Text("Finish")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    } else {
                        Button(action: {
                            // Sıradaki soru
                            questionNumber += 1
                            selectedAnswerId = nil
                        }) {
                            Text("Next")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            } else {
                // loading..
                ProgressView("Loading Questions...")
                    .onAppear {
                        loadQuizDetails()
                    }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
    
    private func loadQuizDetails() {
        let request = AF.request("https://goldfish-app-zjg23.ondigitalocean.app/questions/quiz/\(quizId)")
        
        request.responseDecodable(of: [QuizDetail].self) { response in
            quizDetail = response.value ?? []
        }
    }
}

struct AnswerOptionView: View {
    var content: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            // Şık tasarımı
            Circle()
                .stroke(isSelected ? Color.blue : Color.gray, lineWidth: 2)
                .frame(width: 20, height: 20)
                .overlay(
                    Circle()
                        .fill(isSelected ? Color.blue : Color.clear)
                        .frame(width: 12, height: 12)
                )
            
            Text(content)
                .foregroundColor(.black)
                .padding(.leading, 10)
            
            Spacer()
        }
        .padding()
        .background(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}



#Preview {
    QuestionScreen(quizId: "66ba496ab73bed94392d09a2")
}
