//
//  CustomMenuButton.swift
//  TaskManagment
//
//  Created by Usef on 05/05/2025.
//

import SwiftUI

struct CustomMenuButton: View {
    var onViewTaskTapped: (() -> Void)? = nil
    var body: some View {
        VStack {
            RoundedRectangle(
                cornerSize: CGSize(width: 5, height: 5),
                style: .circular
            )
            .frame(width: 26, height: 26)
            .foregroundStyle(.ultraThinMaterial)
            .overlay {
                HStack(spacing: 3) {
                    ForEach(0..<3) { _ in
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 3, height: 3)
                    }
                }
            }
            .onTapGesture {
                if let action = onViewTaskTapped {
                    action()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    CustomMenuButton() {
        print("Tapped")
    }
}
