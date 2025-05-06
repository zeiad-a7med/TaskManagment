//
//  CustomSecureField.swift
//  M-Commerce-App
//
//  Created by Zeiad on 16/02/2025.
//

import SwiftUI

struct CustomSecureField: View {
    @State private var text: String = ""
    @FocusState private var isFocused: Bool
    let placeholder: String
    var onChange: (String,Bool) -> Void
    var prefix: (() -> any View)?
    var validationType: ValidationType?
    var characterLimit: Int?

    @State var isVisible: Bool = false
    @State private var errorMessage: String?
    var hasError: Bool { errorMessage != nil }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Prefix view (e.g., magnifying glass icon)
                if prefix != nil {
                    AnyView(prefix!())
                        .foregroundColor(
                            isFocused
                                ? .mainPurple
                                : .mainPurple.opacity(0.5)
                        )
                        .animation(.easeInOut(duration: 0.3), value: isFocused)
                }

                // TextField for search input
                if isVisible {
                    TextField(placeholder, text: $text)
                        .focused($isFocused)
                        .onChange(
                            of: text,
                            {
                                if characterLimit != nil {
                                    if text.count > characterLimit! {
                                        text = String(
                                            text.prefix(characterLimit!)
                                        )
                                    }
                                }
                                if validationType != nil {
                                    if text.isEmpty {
                                        errorMessage = nil
                                    } else {
                                        errorMessage =
                                            TextValidation.validateText(
                                                text,
                                                type: validationType!
                                            )
                                    }
                                }
                                onChange(text,!hasError && !text.isEmpty)
                            }
                        )
                } else {
                    SecureField(placeholder, text: $text)
                        .focused($isFocused)
                        .onChange(
                            of: text,
                            {
                                if characterLimit != nil {
                                    if text.count > characterLimit! {
                                        text = String(
                                            text.prefix(characterLimit!)
                                        )
                                    }
                                }
                                if validationType != nil {
                                    if text.isEmpty {
                                        errorMessage = nil
                                    } else {
                                        errorMessage =
                                            TextValidation.validateText(
                                                text,
                                                type: validationType!
                                            )
                                    }
                                }
                                onChange(text,!hasError && !text.isEmpty)
                            }
                        )

                }

                Button(action: {
                    isVisible.toggle()
                    isFocused = true
                }) {
                    Image(systemName: isVisible ? "eye" : "eye.slash")
                        .foregroundColor(
                            isFocused
                                ? .mainPurple
                                : .mainPurple.opacity(0.5)
                        )
                        .animation(.easeInOut(duration: 0.3), value: isFocused)
                }

            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(.secondary.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        hasError
                            ? .red
                            : isFocused
                                ? .mainPurple
                                : Color.gray.opacity(0.3),
                        lineWidth: isFocused ? 2 : 1
                    )
                    .animation(.easeInOut(duration: 0.3), value: hasError)
                    .animation(.easeInOut(duration: 0.3), value: isFocused)
            )
            // Animate border color
            if let error = errorMessage {
                Text(error)
                    .padding(.leading, 10)
                    .font(.caption)
                    .foregroundColor(.red)
                    .transition(.opacity)  // Smooth slide-in effect
            }
        }
        .animation(.easeInOut(duration: 0.3), value: errorMessage)  // Ensure smooth updates
    }
}

#Preview {
    CustomSecureField(
        placeholder: "Enter your password",
        onChange: { text, _ in
        },
        prefix: {
            Image(systemName: "lock")
        }
    )
    .padding()
}
