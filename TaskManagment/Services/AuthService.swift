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
                // Set display name and photo
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName =
                    registerData.firstName! + " " + registerData.lastName!
                //                if let photoURLString = registerData.photoURL, let photoURL = URL(string: photoURLString) {
                //                    changeRequest.photoURL = photoURL
                //                }
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
            let rootViewController = UIApplication.shared.windows.first?
                .rootViewController
        else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) {
            signInResult,
            error in
            if let error = error {
                print("Google sign-in error: \(error.localizedDescription)")
                return
            }
            guard let user = signInResult?.user else { return }
            let result = GoogleResponse(
                userID: user.userID,
                name: user.profile?.name,
                email: user.profile?.email,
                imageURL: user.profile?.imageURL(withDimension: 200)?
                    .absoluteString ?? "",
                idToken: user.idToken?.tokenString,
                refreshToken: user.refreshToken.tokenString,
                accessToken: user.accessToken.tokenString
            )
            completion(result)
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
                //                    completion(false, "Facebook login failed: \(error.localizedDescription)")
                return
            }

            guard let token = AccessToken.current?.tokenString else {
                //                    completion(false, "Failed to get Facebook access token.")
                return
            }

            let credential = FacebookAuthProvider.credential(
                withAccessToken: token
            )
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("error")
                    //                        completion(false, "Firebase sign in failed: \(error.localizedDescription)")
                } else {
                    print("success")
                    //                        completion(true, "Successfully signed in with Facebook!")
                }
            }
        }
        //        let loginManager = LoginManager()
        //        loginManager.logIn(permissions: ["public_profile", "email"], from: nil)
        //        { result, error in
        //            if let error = error {
        //                print("Facebook login error: \(error.localizedDescription)")
        //                return
        //            }
        //
        //            guard let result = result, !result.isCancelled else {
        //                print("User cancelled Facebook login.")
        //                return
        //            }
        //
        //            // Successfully logged in
        //            print(
        //                "Facebook login success! Token: \(result.token?.tokenString ?? "nil")"
        //            )
        //
        //            // Fetch user data (optional)
        //            let request = GraphRequest(
        //                graphPath: "me",
        //                parameters: ["fields": "id, name, email"],
        //                tokenString: result.authenticationToken?.tokenString,
        //                version: nil,
        //                httpMethod: .get
        //            )
        //
        //            request.start { _, result, error in
        //                if let error = error {
        //                    print(
        //                        "Failed to fetch Facebook user data: \(error.localizedDescription)"
        //                    )
        //                    return
        //                }
        //
        //                if let userData = result as? [String: Any] {
        //                    print("Facebook user data: \(userData)")
        //                    // Extract user info (e.g., userData["email"], userData["name"])
        //                }
        //            }
        //        }
    }
    static func signInWithApple(completion: @escaping (AppleResponse) -> Void) {

    }

}
