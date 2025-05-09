//
//  AuthService.swift
//  TaskManagment
//
//  Created by Zeiad on 06/05/2025.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit


protocol AuthServiceProtocol {
    static func signUp(
        registerData: RegisterModel,
        completion: @escaping (RegisterResponse) -> Void
    )
    static func signInWithGoogle(
        completion: @escaping (GoogleResponse) -> Void
    )
    static func signInWithFacebook(
        completion: @escaping (GoogleResponse) -> Void
    )
}

class AuthService: AuthServiceProtocol {
    static func signUp(
        registerData: RegisterModel,
        completion: @escaping (RegisterResponse) -> Void
    ) {
        completion(
            RegisterResponse(message: "success register", success: true)
        )
    }
    
    static func signInWithGoogle(
        completion: @escaping (GoogleResponse) -> Void
    ) {
        guard
            let rootViewController = UIApplication.shared.windows.first?
                .rootViewController
        else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                print("Google sign-in error: \(error.localizedDescription)")
                return
            }
            guard let user = signInResult?.user else { return }
            let result = GoogleResponse(
                userID: user.userID,
                name: user.profile?.name,
                email: user.profile?.email,
                imageURL: user.profile?.imageURL(withDimension: 100)?.absoluteString ?? "",
                idToken: user.idToken?.tokenString,
                refreshToken: user.refreshToken.tokenString,
                accessToken: user.accessToken.tokenString
            )
            completion(result)
        }
    }
    
    static func signInWithFacebook(completion: @escaping (GoogleResponse) -> Void) {
        let loginManager = LoginManager()
                loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                    if let error = error {
                        print("Facebook login error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let result = result, !result.isCancelled else {
                        print("User cancelled Facebook login.")
                        return
                    }
                    
                    // Successfully logged in
                    print("Facebook login success! Token: \(result.token?.tokenString ?? "nil")")
                    
                    // Fetch user data (optional)
                    let request = GraphRequest(
                        graphPath: "me",
                        parameters: ["fields": "id, name, email"],
                        tokenString: AccessToken.current?.tokenString,
                        version: nil,
                        httpMethod: .get
                    )
                    
                    request.start { _, result, error in
                        if let error = error {
                            print("Failed to fetch Facebook user data: \(error.localizedDescription)")
                            return
                        }
                        
                        if let userData = result as? [String: Any] {
                            print("Facebook user data: \(userData)")
                            // Extract user info (e.g., userData["email"], userData["name"])
                        }
                    }
                }
    }
    
    private func fetchFacebookUserData() {
            
        }

}
