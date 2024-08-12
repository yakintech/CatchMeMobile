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
    var _id : String = ""
    var title : String = ""
    var questions : [Question] = []
}


struct Question : Codable {
    var _id : String = ""
    var title : String = ""
}
