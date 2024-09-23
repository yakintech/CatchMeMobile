//
//  ConfirmCodeScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 19.08.2024.
//

import SwiftUI
import Combine
import Alamofire

struct ConfirmCodeScreen: View {
    @State var confirmCode : String = ""
    @State var isActive : Bool = false
    
    @EnvironmentObject var authModel: AuthModel
    
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
            
            SecureField("Confirm Code", text: $confirmCode)
                .keyboardType(.numberPad) //sayı klavyesini açar
                .padding()
                .background(Color.black.opacity(0.08))
                .cornerRadius(10)
                .onReceive(Just(confirmCode)) { _ in
                        if confirmCode.count > 4 {
                            confirmCode = String(confirmCode.prefix(4))
                        }
                    }
                .padding()
            

            Button(action: {
                let userId = UserDefaults.standard.string(forKey: "userId")
                let confirmParameter : [String : Any] = [
                    "confirmCode" : confirmCode,
                    "id":userId!
                ]
 
                let url = "\(authModel.baseURL)/confirm"
                
                //confirm code ve userid sini backende gönderiyorum. eğer doğruysa TAB açılacak!
                AF.request(url, method: .post, parameters: confirmParameter, encoding: JSONEncoding.default).responseDecodable(of: ConfirmCodeResponseModel.self){response in
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
