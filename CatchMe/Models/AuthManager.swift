import AuthenticationServices
import FirebaseAuth
import FirebaseCore

enum AuthState {
    case authenticated // Anonymously authenticated in Firebase.
    case signedIn // Authenticated in Firebase using one of service providers, and not anonymous.
    case signedOut // Not authenticated in Firebase.
}

@MainActor
class AuthManager: ObservableObject {
    @Published var user: User?
    @Published var authState = AuthState.signedOut
    
    
    // import GoogleSignIn
    func googleAuth(_ user: GIDGoogleUser) async throws -> AuthDataResult? {
        guard let idToken = user.idToken?.tokenString else { return nil }
        
        // 1.
        let credentials = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )
        do {
            // 2.
            return try await authenticateUser(credentials: credentials)
        }
        catch {
            print("FirebaseAuthError: googleAuth(user:) failed. \(error)")
            throw error
        }
    }
}
