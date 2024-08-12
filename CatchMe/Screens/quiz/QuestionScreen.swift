//
//  QuestionScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI
import Alamofire

struct QuestionScreen: View {
    
    var quizId : String
    @State var quizDetail : QuizDetail = QuizDetail()
    
    var body: some View {
        VStack{
            
           
            
            if(quizDetail.questions.count > 0){
                Text(quizDetail.questions[0].title)
                    .padding()
            }
        }
        .onAppear(){
            let request = AF.request("http://localhost:3000/questions/quiz/\(quizId)")
            
            request.responseDecodable(of: QuizDetail.self){response in
                quizDetail = response.value ?? QuizDetail()
            }
        }
    }
}
