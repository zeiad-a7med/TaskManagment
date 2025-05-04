//
//  BubblesBackground.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI

struct BubblesBackground: View {
    let bubbles:[Bubble] = [
        Bubble(color: .yellow, x: 160, y: -420),
        Bubble(color: .green, x: -180, y: -220),
        Bubble(color: .blue, x: 190, y: -120),
        Bubble(color: .purple, x: -100, y: 80),
        Bubble(color: .red, x: 30, y: 400),
    ]
    var body: some View {
        ZStack {
            ForEach(0..<bubbles.count, id: \.self) { index in
                let bubble = bubbles[index]
                ColorBubble(bubble: bubble)
            }
            
        }
    }
}
struct Bubble {
    var color: Color
    var x: CGFloat
    var y: CGFloat
}

#Preview {
    BubblesBackground()
}
