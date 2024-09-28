//
//  ProfileMainScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI
import PhotosUI

struct ProfileMainScreen: View {
    @EnvironmentObject var authmodel : AuthModel
    
    
    var body: some View {
        VStack {
            Button("Logout"){
                UserDefaults.standard.setValue(false, forKey: "isLogin")
                authmodel.isLogin = false
                
            }
            .padding()
        }
    }
}

#Preview {
    ProfileMainScreen()
}
