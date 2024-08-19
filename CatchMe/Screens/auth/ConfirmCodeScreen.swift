//
//  ConfirmCodeScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 19.08.2024.
//

import SwiftUI

struct ConfirmCodeScreen: View {
    @State var confirmCode : String = ""
    @State var isActive : Bool = false
    var body: some View {
        VStack{
            
            NavigationLink(destination: TabMain(), isActive: $isActive){
                EmptyView()
            }
          
            TextField("Confirm Code", text: $confirmCode)
                .padding()
            Button("Send"){
                isActive = true
            }
               
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ConfirmCodeScreen()
}
