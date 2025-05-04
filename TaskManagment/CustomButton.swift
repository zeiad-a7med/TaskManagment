//
//  CustomButton.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var systemIconName: String?
    var width: CGFloat?
    var onTap: (() -> Void)?
    @Binding var isButtonEnabled: Bool
    var body: some View {
        Button(
            action: {
                onTap?()
            },
            label: {
                HStack {
                    if systemIconName != nil {
                        Image(systemName: systemIconName!)
                            .foregroundStyle(.white)
                    }

                    Text(text)
                        .foregroundStyle(.white)
                }
            }
        )
        .disabled(!isButtonEnabled)
        .padding(20)
        .padding(.horizontal, width)
        .background(
            .mainPurple
        )
        .cornerRadius(20)
        .animation(.easeInOut(duration: 0.3), value: isButtonEnabled)
    }
}

#Preview {
    CustomButton(
        text: "Add to Cart",
        systemIconName: "handbag",
        width: 100,
        onTap: {
            print("Tapped")
        },
        isButtonEnabled: .constant(true)
    )
}
