//
//  BubblesBackground.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI

struct BubblesBackground: View {
    var body: some View {
        ZStack {
            ForEach(0..<Constant.backgroundBubble.count, id: \.self) { index in
                let bubble = Constant.backgroundBubble[index]
                ColorBubble(bubble: bubble)
            }
        }
    }
}
#Preview {
    BubblesBackground()
}
