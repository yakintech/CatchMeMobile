import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Google Sign-In yapılandırması
        let config = GIDConfiguration(clientID: clientID)
        
        // SwiftUI'de rootViewController'ı almak için
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }
        
        // Google Sign-In başlatılıyor
        GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { user, error in
            if let error = error {
                print("Google Sign-In Error: \(error.localizedDescription)")
                return
            }
            
            // Firebase Authentication için token al
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            // Firebase ile oturum açma
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Firebase Sign-In Error: \(error.localizedDescription)")
                    return
                }
                
                // Başarılı oturum açma
                self.isAuthenticated = true
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
