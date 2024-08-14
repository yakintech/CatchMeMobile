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
    @State var quizDetail : [QuizDetail] = []
    @State var questionNumber : Int = 0
    
    var body: some View {
        VStack{
            if(quizDetail.count > 0){
                Text(quizDetail[questionNumber].question.title)
                    .padding()
                
                ForEach(quizDetail[questionNumber].answers, id:\._id){item in
                    Text(item.content)
                        .padding()
                }
                
                //eğer bu ife giriyorsa bu arkadaş son sorudadır
                if(questionNumber == quizDetail.count - 1 ){
                    Button("Finish"){
                        
                    }
                }
                else{
                    Button("Next"){
                        questionNumber = questionNumber + 1
                    }
                }
                
               
            }
        }
        .onAppear(){
            let request = AF.request("http://localhost:3000/questions/quiz/\(quizId)")
            
            request.responseDecodable(of: [QuizDetail].self){response in
                quizDetail = response.value ?? []
            }
        }
    }
}
