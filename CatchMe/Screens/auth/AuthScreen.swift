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
                
                Text("Catch Me")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .bold()
                   

                HStack{
                    Image(systemName: "envelope.fill")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    TextField("Email", text: $email)
                }
                .padding()
                .background(Color.black.opacity(0.08))
                .cornerRadius(10)
                .padding()
                
                Button {
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
                } label: {
                   HStack{
                        Image(systemName: "paperplane.fill")
                        Text("Send")
                            .bold()
                    }
                    .padding()
                    .padding(.horizontal,100)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
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
