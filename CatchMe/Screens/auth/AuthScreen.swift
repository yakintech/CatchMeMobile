//
//  AuthScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 19.08.2024.
//

import SwiftUI

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
