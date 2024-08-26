//
//  AuthScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 19.08.2024.
//

import SwiftUI
import Alamofire

struct AuthScreen: View {
    @State var email : String = ""
    @State var isActive : Bool = false
    var body: some View {
        
        NavigationView{
            
            VStack{
                TextField("Email", text: $email)
                    .padding()
                Button("Send"){
                    //burada email apiye gidiyor ve apiden response geldiğinde ConfirmCode ekranına gideceğiz
                    isActive = true
                    
                    let authModel : [String : Any] = [
                                       "email" : email
                                   ]
                    
                    
                    AF.request("https://goldfish-app-zjg23.ondigitalocean.app/auth", method: .post, parameters: authModel, encoding: JSONEncoding.default).responseDecodable(of: AuthEMailResponseModel.self){response in
                        if(response.response?.statusCode == 200){
                            UserDefaults.standard.setValue(response.value?.id, forKey: "userId")
                            isActive = true
                        }
                        else{
                            
                        }
                    }
                    
                }
                 
                NavigationLink(destination: ConfirmCodeScreen(), isActive: $isActive){
                    EmptyView()
                }
            }
        }
            
        
    }
}

#Preview {
    AuthScreen()
}
