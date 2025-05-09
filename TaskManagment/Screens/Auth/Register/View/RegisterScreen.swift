//
//  LoginScreen.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI

struct RegisterScreen: View {
    @StateObject var viewModel = RegisterViewModel()
    var body: some View {
        ScrollView {
            Spacer().frame(height: UIScreen.main.bounds.height * 0.1)
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
                        onChange: { value, valid in
                            viewModel.updateUserInfo(
                                registerData: viewModel.registerModel.copyWith(
                                    firstName: valid ? value : ""
                                )
                            )
                        },
                        validationType: .name,
                        initialText: .constant("")
                    )
                }
                Spacer().frame(height: 20)

                VStack(alignment: .leading) {
                    CustomTextField(
                        placeholder: "Last name",
                        onChange: { value, valid in
                            viewModel.updateUserInfo(
                                registerData: viewModel.registerModel.copyWith(
                                    lastName: valid ? value : ""
                                )
                            )
                        },
                        validationType: .name,
                        initialText: .constant("")
                    )
                }
                Spacer().frame(height: 20)

                VStack(alignment: .leading) {
                    CustomTextField(
                        placeholder: "Enter your email",
                        onChange: { value, valid in
                            viewModel.updateUserInfo(
                                registerData: viewModel.registerModel.copyWith(
                                    email: valid ? value : ""
                                )
                            )
                        },
                        validationType: .email,
                        initialText: .constant(""),
                    )
                }
                Spacer().frame(height: 20)
                VStack(alignment: .leading) {
                    CustomSecureField(
                        placeholder: "Enter your password",
                        onChange: { value, valid in
                            viewModel.updateUserInfo(
                                registerData: viewModel.registerModel.copyWith(
                                    password: valid ? value : ""
                                )
                            )

                        },
                        validationType: .password,
                    )
                }

                Spacer().frame(height: 20)
                VStack(alignment: .leading) {
                    CustomSecureField(
                        placeholder: "Confirm password",
                        onChange: { value, valid in
                            viewModel.updateUserInfo(
                                registerData: viewModel.registerModel.copyWith(
                                    confirmPassword: valid ? value : ""
                                )
                            )
                        },
                        validationType: .password,
                    )
                }

                Spacer().frame(height: 40)
                CustomButton(
                    text: "Sign up",
                    width: UIScreen.main.bounds.width * 0.6,
                    onTap: {
                        viewModel.signUp()
                    },
                    isButtonEnabled: $viewModel.isFormEnabled
                )
            }.padding()
        }.background(
            BubblesBackground()
        )
    }
}

#Preview {
    RegisterScreen()
}
