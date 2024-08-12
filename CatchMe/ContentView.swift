//
//  ContentView.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            
            QuizScreen()
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                }
            
            GameHomeScreen()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                }
            
            ProfileMainScreen()
                .tabItem {
                    Image(systemName: "brain.head.profile")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
