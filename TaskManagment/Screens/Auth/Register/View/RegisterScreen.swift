//
//  LoginScreen.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI

struct RegisterScreen: View {
    var body: some View {
        VStack {
            Text("Sign up")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Spacer().frame(height: 20)
            Text("Sign up now to start managing your tasks")
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer().frame(height: 50)
            
            VStack(alignment: .leading) {
                CustomTextField(
                    placeholder: "First name",
                    onChange: { val in

                    },
                    initialText: .constant("")
                )
            }
            Spacer().frame(height: 20)
            
            VStack(alignment: .leading) {
                CustomTextField(
                    placeholder: "Last name",
                    onChange: { val in

                    },
                    initialText: .constant("")
                )
            }
            Spacer().frame(height: 20)
            
            VStack(alignment: .leading) {
                CustomTextField(
                    placeholder: "Enter your email",
                    onChange: { val in

                    },
                    initialText: .constant("")
                )
            }
            Spacer().frame(height: 20)
            VStack(alignment: .leading) {
                CustomSecureField(
                    placeholder: "Enter your password"
                ) { val in

                }
            }
            
            Spacer().frame(height: 20)
            VStack(alignment: .leading) {
                CustomSecureField(
                    placeholder: "Repeat password"
                ) { val in

                }
            }
            
            Spacer().frame(height: 40)
            CustomButton(
                text: "Sign up",
                width: UIScreen.main.bounds.width * 0.6,
                onTap: {
                    NavigationManager.shared.push(.home)
                },
                isButtonEnabled: .constant(true)
            )
        }.padding()
            .background(
                BubblesBackground()
            )
    }
}

#Preview {
    RegisterScreen()
}
