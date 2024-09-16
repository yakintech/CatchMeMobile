//
//  ContentView.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var loginStatus = UserDefaults.standard.bool(forKey: "isLogin")
    @StateObject var authmodel = AuthModel()
    
    var body: some View {
        
        VStack{
            if(authmodel.isLogin){
                    TabMain()
            }
            else{
                   AuthScreen()
            }
        }
        .environmentObject(authmodel)
        .onAppear(){
            authmodel.authControl()
        }
    }

    
    
}

#Preview {
    ContentView()
}
