//
//  CircularProgressView.swift
//  TaskManagment
//
//  Created by Usef on 05/05/2025.
//

import SwiftUI

struct CircularProgressView: View {
    var percentage: Float
    var taskType: TasksType?
    var width: CGFloat?
    var height: CGFloat?
    var fontSize: CGFloat?
    var strokeSize: CGFloat?
    let mainWidth: CGFloat = 80
    let mainHeight: CGFloat = 80
    var body: some View {
        ZStack {
            Circle()
                .fill((taskType != nil) ? .clear : .white.opacity(0.4))
                .frame(width: width ?? mainWidth, height: mainHeight)

            Circle()
                .stroke(
                    (taskType != nil)
                        ? taskType?.color.opacity(0.3) ?? .white.opacity(0.3)
                        : .white.opacity(0.3),
                    style: StrokeStyle(
                        lineWidth: strokeSize ?? 10,
                        lineCap: .round
                    )
                )
                .frame(
                    width: (width ?? mainWidth) - 10,
                    height: (height ?? mainHeight) - 10
                )

            Circle()
                .trim(from: 0, to: CGFloat(percentage))
                .stroke(
                    (taskType != nil) ? taskType?.color ?? .white : .white,
                    style: StrokeStyle(
                        lineWidth: strokeSize ?? 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))  // Start from top
                .frame(
                    width: (width ?? mainWidth) - 10,
                    height: (height ?? mainHeight) - 10
                )

            Circle()
                .frame(
                    width: (width ?? mainWidth) - 20,
                    height: (height ?? mainHeight) - 20
                )
                .foregroundColor((taskType != nil) ? .clear : .mainPurple)

            Text("\(Int(percentage * 100))%")
                .foregroundColor((taskType != nil) ? .primary : .white)
                .font(.system(size: fontSize ?? 16, weight: .bold))
        }
    }
}

#Preview {
    CircularProgressView(percentage: 0.3)
}
