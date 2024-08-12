//
//  QuizScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI
import Alamofire

struct QuizScreen: View {
    
    @State var quizzes : [Quiz] = []
    
    var body: some View {
        NavigationView{
            VStack{
                
                ForEach(quizzes, id:\._id){item in
                    
                    NavigationLink(destination: QuestionScreen(quizId: item._id)){
                        Text(item.title)
                            .padding()
                              }
                }
                
            }
            .onAppear(){
                
                let request = AF.request("http://localhost:3000/quizzes")
                
                request.responseDecodable(of: [Quiz].self){response in
                    quizzes = response.value ?? []
                }
            }
        }
    }
}

#Preview {
    QuizScreen()
}
