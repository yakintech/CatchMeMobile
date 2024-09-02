//
//  SplashScreen.swift
//  CatchMe
//
//  Created by Esma Özcan on 29.08.2024.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
       ZStack {
            Color(red: 0.4157, green: 0.2392, blue: 0.9098)
                .ignoresSafeArea() // Tüm ekranı kaplamak için

            VStack {
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
