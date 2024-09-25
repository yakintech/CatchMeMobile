//
//  ProfileMainScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 12.08.2024.
//

import SwiftUI
import PhotosUI

struct ProfileMainScreen: View {
    @State var isActive : Bool = false
    @EnvironmentObject var authmodel : AuthModel
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    var body: some View {
        VStack {
            Button("Send"){
                
            }
            .padding()
            
            PhotosPicker("Select profile image", selection: $avatarItem, matching: .images)
            
                   avatarImage?
                       .resizable()
                       .scaledToFit()
                       .frame(width: 300, height: 300)
               }
               .onChange(of: avatarItem) {
                   Task {
                       if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                           avatarImage = loaded
                    
                       } else {
                           print("Failed")
                       }
                   }
                 
                   
               }
        
  
        
        
    }
}

#Preview {
    ProfileMainScreen()
}
