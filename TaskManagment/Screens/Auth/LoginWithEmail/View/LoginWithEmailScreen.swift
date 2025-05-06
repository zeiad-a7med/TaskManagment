//
//  LoginScreen.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI

struct LoginWithEmailScreen: View {
    var body: some View {
        VStack {
            Text("Sign in now!")
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
            VStack(alignment: .leading) {
                CustomTextField(
                    placeholder: "Enter your email",
                    onChange: { value, valid in

                    },
                    initialText: .constant("")
                )
            }
            Spacer().frame(height: 30)
            VStack(alignment: .leading) {
                CustomSecureField(
                    placeholder: "Enter your password"
                ) { value, valid in

                }
            }
            Spacer().frame(height: 20)
            HStack {
                Toggle(isOn: .constant(false)) {
                    Text("Remember me")
                }
                .toggleStyle(CheckboxToggleStyle())
                Spacer()
                Text("Forget password")
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .onTapGesture {
                    }

            }
            Spacer().frame(height: 20)
            CustomButton(
                text: "Sign in",
                width: UIScreen.main.bounds.width * 0.6,
                onTap: {
                    NavigationManager.shared.push(.home)
                },
                isButtonEnabled: .constant(true)
            )
            
            Text("Don't have an account? Create account")
                .font(.footnote)
                .foregroundColor(.blue)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .onTapGesture {
                    NavigationManager.shared.push(.register)
                }
        }.padding()
            .background(
                BubblesBackground()
            )
    }
}
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(
                    systemName: configuration.isOn
                        ? "checkmark.square" : "square"
                )
                .foregroundColor(configuration.isOn ? .blue : .secondary)
                configuration.label
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LoginWithEmailScreen()
}
