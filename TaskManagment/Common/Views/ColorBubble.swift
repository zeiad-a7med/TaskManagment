//
//  ColorBubble.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI

struct ColorBubble: View {
    var bubble: Bubble
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [
                        bubble.color.opacity(bubble.opacity),
                        bubble.color.opacity(0.0),
                    ],
                    center: .center,
                    startRadius: 0,
                    endRadius: 100
                )
            )
            .frame(width: 200, height: 200)
            .offset(x: bubble.x, y: bubble.y)
    }
}

#Preview {
    ColorBubble(
        bubble: Bubble(color: .purple, x: 0, y: 0,opacity: 0.4)
    )
}
