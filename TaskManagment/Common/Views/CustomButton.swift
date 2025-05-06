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
    var imageName: String?
    var width: CGFloat?
    var onTap: (() -> Void)?
    var backgroundColor: Color?
    var fontColor: Color?
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
                            .foregroundStyle(fontColor ?? .white)
                    }
                    if imageName != nil {
                        Image(imageName!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }

                    Text(text)
                        .foregroundStyle(fontColor ?? .white)
                }
                .frame(width: width)

            }
        )
        .disabled(!isButtonEnabled)
        .padding(20)
        .background(
            (backgroundColor ?? .mainPurple).opacity(isButtonEnabled ? 1 : 0.5)
        )
        .cornerRadius(20)
        .animation(.easeInOut(duration: 0.3), value: isButtonEnabled)
    }
}

#Preview {
    CustomButton(
        text: "Add to Cart",
        systemIconName: "handbag",
        width: 300,
        onTap: {
            print("Tapped")
        },
        isButtonEnabled: .constant(true)
    )
}
