//
//  LoginScreen.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI
import GoogleSignIn
import FacebookLogin

struct LoginChannelsScreen: View {
    @StateObject var viewModel = LoginChannelsViewModel()
    var body: some View {
        ScrollView {
            Spacer().frame(height: UIScreen.main.bounds.height * 0.1)
            VStack {
                Text("Welcom Back!")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Spacer().frame(height: 20)
                Text("Welcome back, please login to continue!")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Spacer().frame(height: 50)
                CustomButton(
                    text: "Continue with email",
                    width: UIScreen.main.bounds.width * 0.6,
                    onTap: {
                        NavigationManager.shared.push(.loginWithEmail)
                    },
                    isButtonEnabled: .constant(true)
                )
                Spacer().frame(height: 20)
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.secondary.opacity(0.5))
                    Spacer()
                    Text("Or")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.secondary.opacity(0.5))
                }
                Spacer().frame(height: 20)
                CustomButton(
                    text: "Sign in with apple",
                    systemIconName: "apple.logo",
                    width: UIScreen.main.bounds.width * 0.6,
                    onTap: {
                        viewModel.signInWithApple()
                    },
                    backgroundColor: .secondary.opacity(0.2),
                    fontColor: .primary,
                    isButtonEnabled: .constant(true),
                    
                )
                CustomButton(
                    text: "Sign in with google",
                    imageName: "google",
                    width: UIScreen.main.bounds.width * 0.6,
                    onTap: {
                        viewModel.singInWithGoogle()
                    },
                    backgroundColor: .secondary.opacity(0.2),
                    fontColor: .primary,
                    isButtonEnabled: .constant(true),
                    
                )
                FacebookSignInButton()
                    .frame(height: 50)
                    .cornerRadius(20)
                    .padding(.vertical)
                    .padding(.horizontal,30)
                    
                CustomButton(
                    text: "Sign in with facebook",
                    imageName: "facebook",
                    width: UIScreen.main.bounds.width * 0.6,
                    onTap: {
                        viewModel.signInWithFacebook()
                    },
                    backgroundColor: .secondary.opacity(0.2),
                    fontColor: .primary,
                    isButtonEnabled: .constant(true),
                    
                )
            }.padding()
        }.background(
            BubblesBackground()
        )
    }
}
#Preview {
    LoginChannelsScreen()
}


struct FacebookSignInButton: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    func makeUIView(context: Context) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["public_profile", "email"]
        button.delegate = context.coordinator
        return button
    }
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
    }
    class Coordinator: NSObject, LoginButtonDelegate {
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if let error = error {
                print("Facebook login failed: \(error.localizedDescription)")
                return
            }
            if let token = result?.token {
                print("Facebook login success. Token: \(token.tokenString)")
                // Optionally: fetch user info
            } else {
                print("Facebook login cancelled.")
            }
        }

        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            print("User logged out of Facebook.")
        }
    }
}
