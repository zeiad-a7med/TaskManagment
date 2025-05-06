//
//  TaskTypeIcon.swift
//  TaskManagment
//
//  Created by Usef on 05/05/2025.
//

import SwiftUI

struct TaskTypeIcon: View {
    var taskType: TasksType
    var width: CGFloat?
    var height: CGFloat?
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 7, height: 7))
                .frame(width: width ?? 25, height: height ?? 25)
                .foregroundStyle(taskType.color.opacity(0.2))
            Image(systemName: taskType.imgName)
                .resizable()
                .frame(width: (width ?? 24) / 2, height: (height ?? 24) / 2)
                .foregroundStyle(taskType.color)
        }
    }
}

#Preview {
    TaskTypeIcon(taskType: .dailyStudy)
}
