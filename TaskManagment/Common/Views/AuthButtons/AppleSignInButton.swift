//
//  AppleSignInButton.swift
//  TaskManagment
//
//  Created by Usef on 10/05/2025.
//

import AuthenticationServices
import SwiftUI

struct AppleSignInButton: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("userID") var userID: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("email") var email: String = ""
    var onTap: (() -> Void)
    var body: some View {
        SignInWithAppleButton(.continue) { request in
            request.requestedScopes = [.email, .fullName]
        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                print(authorization)
                switch authorization.credential {
                case let credential as ASAuthorizationAppleIDCredential:

                    if let email = credential.email {
                        self.email = email
                    }

                    let userID = credential.user
                    guard !userID.isEmpty else {
                        return
                    }
                    self.userID = userID

                    let firstName = credential.fullName?.givenName ?? ""
                    let lastName = credential.fullName?.familyName ?? ""
                    self.firstName = firstName
                    self.lastName = lastName
                    
                    onTap()
                    
                    break

                default:
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
        .frame(height: 50)
        .cornerRadius(50)
        .padding()
        .padding(.horizontal, 20)
        .id(colorScheme)
    }
}

#Preview {
    AppleSignInButton() {
        print("SignIn With Apple Button Tapped")
    }
}
