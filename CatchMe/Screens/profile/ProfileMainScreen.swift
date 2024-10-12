//
//  ProfileMainScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI
import PhotosUI
import GoogleSignIn

struct ProfileMainScreen: View {
    @EnvironmentObject var authmodel : AuthModel
    
    
    var body: some View {
        VStack {
            Button("Logout"){
                UserDefaults.standard.setValue(false, forKey: "isLogin")
                GIDSignIn.sharedInstance.signOut()
                authmodel.isLogin = false
                print(authmodel.isLogin)
                
            }
            .padding()
        }
    }
}

#Preview {
    ProfileMainScreen()
}
