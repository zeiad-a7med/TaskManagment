//
//  BubblesBackground.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI

struct BubblesBackground: View {
    @State private var animatedBubbles = Constant.backgroundBubble
    @State private var isAnimationStarted = false

    var body: some View {
        ZStack {
            ForEach(animatedBubbles) { bubble in
                ColorBubble(bubble: bubble)
            }
        }
        .onAppear {
            startFloatingAnimation()
        }
    }

    private func startFloatingAnimation() {
        if isAnimationStarted{
            return
        }
        isAnimationStarted = true
        Timer.scheduledTimer(withTimeInterval: 5 , repeats: true) { _ in
            withAnimation(.easeInOut(duration: 5)) {
                animatedBubbles = animatedBubbles.map { bubble in
                    var newBubble = bubble
                    
                    let screenWidth = UIScreen.main.bounds.width
                    let screenHeight = UIScreen.main.bounds.height
                    // Randomize a slight movement
                    newBubble.y = CGFloat.random(in: -(screenHeight/2)...(screenHeight/2))
                    newBubble.x = CGFloat.random(in: -(screenWidth/2)...(screenWidth/2))
                    newBubble.opacity = CGFloat.random(in: 0...0.3)
                    return newBubble
                }
            }
        }
    }
}
#Preview {
    BubblesBackground()
}
