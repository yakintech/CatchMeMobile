//
//  ConfirmCodeScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 19.08.2024.
//

import SwiftUI
import Alamofire

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
                var userId = UserDefaults.standard.string(forKey: "userId")
                let confirmParameter : [String : Any] = [
                    "confirmCode" : confirmCode,
                    "id":userId!
                ]
 
                //confirm code ve userid sini backende gönderiyorum. eğer doğruysa TAB açılacak!
                AF.request("https://goldfish-app-zjg23.ondigitalocean.app/auth", method: .post, parameters: confirmParameter, encoding: JSONEncoding.default).responseDecodable(of: ConfirmCodeResponseModel.self){response in
                    if(response.response?.statusCode == 200){
                        isActive = true;
                    }
                    else{
                        print("Confirm code hatalı!")
                    }
                }
            }
               
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ConfirmCodeScreen()
}
