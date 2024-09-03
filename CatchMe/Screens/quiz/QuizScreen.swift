//
//  QuizScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI
import Alamofire

struct QuizScreen: View {
    
    @State var quizzes: [Quiz] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack(alignment: .center){
                        Text("Catch Me App!")
                            .font(.title)
                            .bold()
                            .padding(.top, 20)
                    }
                    
                    
                    ForEach(quizzes, id: \._id) { item in
                        NavigationLink(destination: QuestionScreen(quizId: item._id)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(item.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .lineLimit(2)
                                }
                                
                                Spacer()
                            
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.accentColor)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: .blue.opacity(0.4), radius: 5, x: 0, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.accentColor.opacity(0.5), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .onAppear(){
                    
                    let request = AF.request("https://goldfish-app-zjg23.ondigitalocean.app/quizzes")
                    
                    request.responseDecodable(of: [Quiz].self){response in
                        quizzes = response.value ?? []
                    }
                }
            }
        }
    }
    

}

#Preview {
    QuizScreen()
}
