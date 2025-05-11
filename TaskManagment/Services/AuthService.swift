//
//  AuthService.swift
//  TaskManagment
//
//  Created by Zeiad on 06/05/2025.
//

import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn
import UIKit

protocol AuthServiceProtocol {
    static func signUp(
        registerData: RegisterModel,
        completion: @escaping (RegisterResponse) -> Void
    )
    static func signIn(
        signInData: SignInModel,
        completion: @escaping (LoginResponse) -> Void
    )
    static func signInWithGoogle(
        completion: @escaping (GoogleResponse) -> Void
    )
    static func signInWithFacebook(
        completion: @escaping (FacebookResponse) -> Void
    )
    static func signInWithApple(
        completion: @escaping (AppleResponse) -> Void
    )
}

class AuthService: AuthServiceProtocol {
    static func signIn(
        signInData: SignInModel,
        completion: @escaping (LoginResponse) -> Void
    ) {
        Auth.auth().signIn(
            withEmail: signInData.email!,
            password: signInData.password!
        ) {
            authResult,
            error in
            if let error = error {
                print("error")
            } else if let user = authResult?.user {
                user.reload { reloadError in  // Refresh user info
                    if let reloadError = reloadError {
                        print("error reload")
                    } else {
                        if user.isEmailVerified {
                            print("email verified")
                        } else {
                            print("email not verified")
                        }
                    }
                }
            }
        }
    }

    static func signUp(
        registerData: RegisterModel,
        completion: @escaping (RegisterResponse) -> Void
    ) {
        Auth.auth().createUser(
            withEmail: registerData.email!,
            password: registerData.password!
        ) { authResult, error in
            if let error = error as? NSError {
                if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    print("Error: Email already in use")
                } else {
                    print("Failed to register\nPlease try again later!")
                }
            } else if let user = authResult?.user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName =
                    registerData.firstName! + " " + registerData.lastName!
                changeRequest.commitChanges { profileError in
                    if let profileError = profileError {
                        print(
                            "Failed to update user profile: \(profileError.localizedDescription)"
                        )
                        return
                    }
                }
                user.sendEmailVerification { verificationError in
                    if let verificationError = verificationError {
                        user.delete()
                        print(
                            "Failed to send verification email\nPlease try again later"
                        )
                    } else {
                        print("Verification email sent")
                        // Return success via completion handler
                        completion(
                            RegisterResponse(
                                message:
                                    "Registered and verification email sent.",
                                success: true
                            )
                        )
                    }
                }
            }
        }
    }

    static func signInWithGoogle(
        completion: @escaping (GoogleResponse) -> Void
    ) {
        guard
            let rootViewController =
                UIApplication.shared.windows.first?
                .rootViewController
        else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) {
            signInResult,
            error in
            //            if let error = error {
            //                print("Google sign-in error: \(error.localizedDescription)")
            //                return
            //            }
            //            guard let user = signInResult?.user,
            //                let idToken = user.idToken?.tokenString,
            //                let accessToken = user.accessToken.tokenString as String?
            //            else {
            //                completion(
            //                    GoogleResponse()
            //                )
            //                return
            //            }
            //
            //            let credential = GoogleAuthProvider.credential(
            //                withIDToken: idToken,
            //                accessToken: accessToken
            //            )
            //
            //            FireBaseAuthService.signInWithProvider(
            //                provider: .Google(accessToken: accessToken),
            //                credential: credential
            //            ) { result in
            //                print(result)
            //                // You can modify this based on your actual result logic
            //                completion(GoogleResponse(success: true, error: nil))
            //            }
        }
    }

    static func signInWithFacebook(
        completion: @escaping (FacebookResponse) -> Void
    ) {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: ["email", "public_profile"], from: nil)
        { result, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            }

            guard let token = AccessToken.current?.tokenString else {
                print("No access token found")
                return
            }
            let credential = FacebookAuthProvider.credential(
                withAccessToken: token
            )
            FireBaseAuthService.signInWithProvider(
                provider: .Facebook,
                credential: credential
            ) { result in
                print(result)
            }
        }
    }
    static func signInWithApple(completion: @escaping (AppleResponse) -> Void) {

    }

    static func updateUserProfile(
        displayName: String?,
        photoURL: URL?,
        completion: @escaping (Bool) -> Void
    ) {
        if let user = Auth.auth().currentUser {
            let changeRequest = user.createProfileChangeRequest()
            if displayName != nil {
                changeRequest.displayName = displayName
            }
            if photoURL != nil {
                changeRequest.photoURL = photoURL
            }
            changeRequest.commitChanges { profileError in
                if let profileError = profileError {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }

}
