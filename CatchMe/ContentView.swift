//
//  ContentView.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var loginStatus = UserDefaults.standard.bool(forKey: "isLogin")
    
    
    var body: some View {
        
        if(loginStatus){
                TabMain()
        }
        else{
                AuthScreen()
        }
        
       
    }
}

#Preview {
    ContentView()
}
