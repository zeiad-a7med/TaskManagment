//
//  AuthService.swift
//  TaskManagment
//
//  Created by Zeiad on 06/05/2025.
//

import UIKit
import GoogleSignIn

protocol AuthServiceProtocol {
    static func signUp(
        registerData: RegisterModel,
        completion: @escaping (RegisterResponse) -> Void
    )
    static func signInWithGoogle(
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

}
