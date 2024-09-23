//
//  UserModel.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 16.09.2024.
//

import Foundation

class AuthModel : ObservableObject {
    @Published var isLogin : Bool = false
    
    
    func authControl(){
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        
        if(isLogin){
            self.isLogin = true
        }
    }
}
