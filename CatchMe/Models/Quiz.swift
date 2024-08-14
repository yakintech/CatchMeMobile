//
//  Quiz.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import Foundation


struct Quiz : Codable{
    var _id : String = ""
    var title : String = ""
}


struct QuizDetail : Codable{
    var question : Question = Question()
    var answers : [Answer] = []
}


struct Question : Codable {
    var _id : String = ""
    var title : String = ""
}

struct Answer : Codable {
    var _id : String = ""
    var content : String = ""
}
