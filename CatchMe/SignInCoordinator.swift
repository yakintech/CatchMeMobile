//
//  SignInCoordinator.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 28.09.2024.
//

import SwiftUI
import GoogleSignIn
import Firebase


class SignInCoordinator: NSObject {
    @ObservedObject var viewModel: AuthViewModel

    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
    
    func signInWithGoogle(presenting viewController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewController) { user, error in
            if let error = error {
                print("Google Sign-In Error: \(error.localizedDescription)")
                return
            }

            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Firebase Sign-In Error: \(error.localizedDescription)")
                    return
                }

                // Başarılı oturum açma
                self.viewModel.isAuthenticated = true
            }
        }
    }
}
