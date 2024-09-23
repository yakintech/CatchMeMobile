//
//  AuthScreen.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 19.08.2024.
//

import SwiftUI
import Alamofire

struct AuthScreen: View {
    @State var email: String = ""
    @State var isActive: Bool = false
    @State var showAlert = false
    @State var alertMessage: String = ""
    
    @EnvironmentObject var authModel: AuthModel

    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Catch Me")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .bold()
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none) // otomatik büyük harf devre dışı
                }
                .padding()
                .background(Color.black.opacity(0.08))
                .cornerRadius(10)
                .padding()
                
                Button {
                    // E-posta alanının boş olup olmadığı & format kontrolü
                    if email.isEmpty {
                        alertMessage = "E-posta alanı boş olamaz."
                        showAlert = true
                    } else if !isValidEmail(email) {
                        alertMessage = "Geçersiz e-posta formatı."
                        showAlert = true
                    } else {
                        isActive = true
                        
                        let authParameter: [String: Any] = [
                            "email": email
                        ]
                        
                        let url = "\(authModel.baseURL)/auth"
                        
                        AF.request(url, method: .post, parameters: authParameter, encoding: JSONEncoding.default).responseDecodable(of: AuthEMailResponseModel.self) { response in
                            if response.response?.statusCode == 200 {
                                UserDefaults.standard.setValue(response.value?.id, forKey: "userId")
                                isActive = true
                            } else {
                                alertMessage = "Bir hata oluştu, lütfen tekrar deneyin."
                                showAlert = true
                            }
                        }
                    }
                    
                } label: {
                    HStack {
                        Image(systemName: "paperplane.fill")
                        Text("Send")
                            .bold()
                    }
                    .padding()
                    .padding(.horizontal, 100)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Uyarı!"), message: Text(alertMessage), dismissButton: .cancel())
                }
                
                NavigationLink(destination: ConfirmCodeScreen(), isActive: $isActive) {
                    EmptyView()
                }
            }
        }
    }
    
    // E-posta formatını kontrol eden fonksiyon
    // Boş string düzenli ifade oluşturmadığı için kullanıcıya uyarı verir
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,64})"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
}

#Preview {
    AuthScreen()
}
