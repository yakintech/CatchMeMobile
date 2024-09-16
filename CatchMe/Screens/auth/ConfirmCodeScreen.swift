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
          
            Text("Enter Verification Code")
                .font(.largeTitle)
                .bold()
                .padding()
                .frame(maxWidth: .infinity,alignment: .leading)
                
            Text("Enter code that we have sent to your email")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            TextField("Confirm Code", text: $confirmCode)
                .keyboardType(.numberPad) //sayı klavyesini açar
                .padding()
                .background(Color.black.opacity(0.08))
                .cornerRadius(10)
                .padding()
            

            Button(action: {
                let userId = UserDefaults.standard.string(forKey: "userId")
                let confirmParameter : [String : Any] = [
                    "confirmCode" : confirmCode,
                    "id":userId!
                ]
 
                //confirm code ve userid sini backende gönderiyorum. eğer doğruysa TAB açılacak!
                AF.request("https://goldfish-app-zjg23.ondigitalocean.app/confirm", method: .post, parameters: confirmParameter, encoding: JSONEncoding.default).responseDecodable(of: ConfirmCodeResponseModel.self){response in
                    if(response.response?.statusCode == 200){
                        UserDefaults.standard.setValue(true, forKey: "isLogin")
                        isActive = true;
                    }
                    else{
                        print("Confirm code hatalı!")
                    }
                }
            }, label: {
                HStack{
                   
                    Text("Login")
                        .bold()
                }
                .padding()
                .padding(.horizontal,100)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                    
                    
            })

            Spacer()
        }
        .navigationBarBackButtonHidden(false)
    }
        
}

#Preview {
    ConfirmCodeScreen()
}
