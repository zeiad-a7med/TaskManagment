//
//  FireBaseAuthService.swift
//  TaskManagment
//
//  Created by Zeiad on 11/05/2025.
//

import FBSDKLoginKit
import FirebaseAuth
import Foundation
import GoogleSignIn
import UIKit

//
//  AuthService.swift
//  TaskManagment
//
//  Created by Zeiad on 06/05/2025.
//

enum AuthProvider {
    case Google(accessToken: String)
    case Facebook
    case Apple
    case GitHub
}

protocol FireBaseAuthServiceProtocol {
    static func signUp(
        email: String,
        password: String,
        displayName: String?,
        withVerficationMail: Bool,
        completion: @escaping (FireBaseResponse) -> Void
    )
    static func signIn(
        email: String,
        password: String,
        withVerficationMail: Bool,
        completion: @escaping (FireBaseResponse) -> Void
    )
    static func signInWithProvider(
        provider: AuthProvider,
        credential: AuthCredential,
        completion: @escaping (FireBaseResponse) -> Void
    )
}

class FireBaseAuthService: FireBaseAuthServiceProtocol {
    static func signIn(
        email: String,
        password: String,
        withVerficationMail: Bool,
        completion: @escaping (FireBaseResponse) -> Void
    ) {
        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) {
            authResult,
            error in
            if let error = error {
                completion(
                    FireBaseResponse(
                        success: false,
                        message: "Failed to sign in"
                    )
                )
            } else if let user = authResult?.user {
                user.reload { reloadError in  // Refresh user info
                    if let reloadError = reloadError {
                        completion(
                            FireBaseResponse(
                                success: false,
                                message: "Failed to sign in"
                            )
                        )
                    } else {
                        let fireBaseUser = FireBaseUser(
                            uid: user.uid,
                            email: user.email,
                            displayName: user.displayName,
                            photoURL: user.photoURL,
                            providerID: user.providerID,
                            isEmailVerified: user.isEmailVerified,
                            phoneNumber: user.phoneNumber
                        )

                        if withVerficationMail {
                            if user.isEmailVerified {
                                completion(
                                    FireBaseResponse(
                                        success: true,
                                        message: "Signed in successfully",
                                        user: fireBaseUser
                                    )
                                )
                            } else {
                                completion(
                                    FireBaseResponse(
                                        success: false,
                                        message: "Email not verified"
                                    )
                                )
                            }
                        } else {
                            completion(
                                FireBaseResponse(
                                    success: true,
                                    message: "Signed in successfully",
                                    user: fireBaseUser
                                )
                            )
                        }
                    }
                }
            }
        }
    }

    static func signUp(
        email: String,
        password: String,
        displayName: String?,
        withVerficationMail: Bool,
        completion: @escaping (FireBaseResponse) -> Void
    ) {
        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { authResult, error in
            if let error = error as? NSError {
                if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    completion(
                        FireBaseResponse(
                            success: false,
                            message:
                                "Error: Email already in use",
                        )
                    )
                } else {
                    completion(
                        FireBaseResponse(
                            success: false,
                            message:
                                "Failed to register\nPlease try again later!",
                        )
                    )
                }
            } else if let user = authResult?.user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { _ in

                }
                if withVerficationMail {
                    user.sendEmailVerification { verificationError in
                        if let verificationError = verificationError {
                            user.delete()
                            completion(
                                FireBaseResponse(
                                    success: false,
                                    message:
                                        "Failed to send verification email\nPlease try again later",
                                )
                            )
                        } else {
                            completion(
                                FireBaseResponse(
                                    success: true,
                                    message:
                                        "Registered and verification email sent.",
                                )
                            )
                        }

                    }
                } else {
                    completion(
                        FireBaseResponse(
                            success: true,
                            message: "Registered successfuly.",
                            user: FireBaseUser(
                                uid: user.uid,
                                email: user.email,
                                displayName: user.displayName,
                                photoURL: user.photoURL,
                                providerID: user.providerID,
                                isEmailVerified: user.isEmailVerified,
                                phoneNumber: user.phoneNumber
                            )
                        )
                    )
                }
            }
        }
    }

    static func signInWithProvider(
        provider: AuthProvider,
        credential: AuthCredential,
        completion: @escaping (FireBaseResponse) -> Void
    ) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(
                    FireBaseResponse(
                        success: false,
                        message: "Failed to sign in"
                    )
                )
            }
            let firebaseAuthService = FireBaseAuthService()
            switch provider {
            case .Facebook:
                firebaseAuthService.fetchAndUpdateFacebookAccountData(authResult: authResult!) { user in
                    completion(FireBaseResponse(
                        success: true, message: "Success Sign In",
                        user: user
                    ))
                }
                break
            case .Google(let accessToken):
                firebaseAuthService.fetchAndUpdateGoogleAccountData(from: accessToken,authResult: authResult!) { user in
                    completion(FireBaseResponse(
                        success: true, message: "Success Sign In",
                        user: user
                    ))
                }
                break
            case .Apple:
                break
            case .GitHub:
                break
            }

            
        }
    }
    private func fetchAndUpdateFacebookAccountData(authResult:AuthDataResult,completion: @escaping (FireBaseUser) -> Void){
        GraphRequest(
            graphPath: "me",
            parameters: ["fields": "id, name, picture.type(large)"]
        ).start { _, result, error in
            if let error = error {
                print(
                    "GraphRequest error: \(error.localizedDescription)"
                )
                return
            }

            if let userData = result as? [String: Any],
                let name = userData["name"] as? String,
                let picture = userData["picture"] as? [String: Any],
                let data = picture["data"] as? [String: Any],
                let photoURL = data["url"] as? String
            {
                let changeRequest = authResult.user
                    .createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.photoURL = URL(string: photoURL)
                changeRequest.commitChanges { _ in
                }
                completion(
                    FireBaseUser(
                        uid: authResult.user.uid,
                        email: authResult.user.email ?? "",
                        displayName: name,
                        photoURL:URL(string: photoURL),
                        providerID: authResult.user.providerID,
                        isEmailVerified: authResult.user.isEmailVerified,
                        refreshToken: authResult.user.refreshToken,
                        phoneNumber:authResult.user.phoneNumber
                    )
                )
            }
        }
    }
    
    private func fetchAndUpdateGoogleAccountData(from accessToken: String, authResult: AuthDataResult, completion: @escaping (FireBaseUser) -> Void) {
        guard let url = URL(string: "https://www.googleapis.com/oauth2/v3/userinfo") else { return }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Google userinfo fetch error: \(error.localizedDescription)")
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let name = json["name"] as? String,
                  let email = json["email"] as? String,
                  let picture = json["picture"] as? String
            else {
                print("Invalid Google userinfo response")
                return
            }

            let changeRequest = authResult.user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.photoURL = URL(string: picture)
            changeRequest.commitChanges { _ in }

            completion(
                FireBaseUser(
                    uid: authResult.user.uid,
                    email: email,
                    displayName: name,
                    photoURL: URL(string: picture),
                    providerID: authResult.user.providerID,
                    isEmailVerified: authResult.user.isEmailVerified,
                    refreshToken: authResult.user.refreshToken,
                    phoneNumber: authResult.user.phoneNumber
                )
            )
        }.resume()
    }

}
