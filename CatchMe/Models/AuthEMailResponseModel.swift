//
//  AuthEMailResponseModel.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 26.08.2024.
//

import Foundation


struct AuthEMailResponseModel : Codable{
        var id:String
}

struct ConfirmCodeResponseModel : Codable{
    var message: String
}
