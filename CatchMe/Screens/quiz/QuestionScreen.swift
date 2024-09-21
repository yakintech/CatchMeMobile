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
    @State private var showCustomDialog: Bool = false
    @State var selectedAnswerId: String? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Sayfayı kapatmak için
    
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.92, blue: 1.0)
                .ignoresSafeArea()
            Image("Image")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .opacity(0.5)
                .cornerRadius(12)
                
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
                            .disabled(selectedAnswerId == nil)
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
                                    .background((selectedAnswerId != nil) ?    Color.purple : Color.gray)
                                    .cornerRadius(10)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)                           
                            }
                            .disabled(selectedAnswerId == nil)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    Button(action: {
                        showCustomDialog = true
                            
                        }) {
                            Text("Exit")
                                
                                .frame(width: 100,height: 40)
                                .foregroundColor(.white)
                                .background(Color.red)
                                
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                } else {
                    // loading..
                    ProgressView("Loading Questions...")
                        .onAppear {
                            loadQuizDetails()
                        }
                }
                
            }
            .disabled(showCustomDialog)
            
            .padding()
        .navigationBarBackButtonHidden(true)
            if showCustomDialog {
                CustomDialogView(
                    title: "Teste Bitirmek İstediğinize Emin Misiniz?",
                    description: "Bu testi kapatırsanız cevaplarınız kaydedilmeyecektir!",
                    primaryButtonText: "Evet",
                    secondaryButtonText: "Hayır",
                    onPrimaryButtonTapped: {
                        showCustomDialog = false
                        presentationMode.wrappedValue.dismiss() // quiz ekranına geri dön
                        
                    },
                    onSecondaryButtonTapped: {
                        showCustomDialog = false
                    }
                )
            }
        }
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
