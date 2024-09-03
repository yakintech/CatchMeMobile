//
//  TabMain.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 19.08.2024.
//

import SwiftUI

struct TabMain: View {
    var body: some View {
        TabView{
            
            QuizScreen()
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                    Text("Quiz")
                }
            
            GameHomeScreen()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Game")
                }
            
            ProfileMainScreen()
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("Profile")
                }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabMain()
}
