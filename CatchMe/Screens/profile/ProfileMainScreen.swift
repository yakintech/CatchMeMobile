//
//  ProfileMainScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI

struct ProfileMainScreen: View {
    @State var isActive : Bool = false
    @EnvironmentObject var authmodel : AuthModel
    
    var body: some View {
        VStack{

            Button("Log out"){
                UserDefaults.standard.setValue(false, forKey: "isLogin")
                authmodel.isLogin = false
            }
        }
    }
}

#Preview {
    ProfileMainScreen()
}
