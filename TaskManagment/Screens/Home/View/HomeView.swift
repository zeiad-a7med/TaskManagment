//
//  HomeView.swift
//  TaskManagment
//
//  Created by Usef on 04/05/2025.
//

import SwiftUI

struct HomeView: View {
    @State var userName: String = "Youssef Elbedwehy"
    @State var taskProgressTxt: String = "Your today's task almost done!"
    @State var percentage: Float = 0.3
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationTopBarView
                ScrollView(showsIndicators: false) {
                    progressTrackingView
                    InProgressSectionView
                    TaskGroupsSectionView
                }
                Spacer()
            }
            CustomTabView()
        }
        .background(
            BubblesBackground()
        )
    }
}

#Preview {
    HomeView()
}

// MARK: In Progress Section View
extension HomeView {
    private var InProgressSectionView: some View {
        VStack(alignment: .leading) {
            SectionTitle(title: "In Progress", numberOfTasks: 3)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    InProgressCardView(
                        taskType: .officeProject,
                        taskTxt: "Grocery shopping for the week",
                        percentage: 0.5
                    )
                    InProgressCardView(
                        taskType: .personalProject,
                        taskTxt: "Grocery shopping for the week",
                        percentage: 0.2
                    )
                    InProgressCardView(
                        taskType: .dailyStudy,
                        taskTxt: "Grocery shopping for the week",
                        percentage: 0.8
                    )
                }
            }
        }
    }
}

struct SectionTitle: View {
    let title: String
    var numberOfTasks: Int
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 24, weight: .semibold))
                .padding(.leading, 20)
            if numberOfTasks > 0 {
                ZStack {
                    Circle()
                        .foregroundStyle(.mainPurple.opacity(0.1))
                        .frame(width: 24, height: 24)
                    Text("\(numberOfTasks)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.mainPurple)
                }
            }
            Spacer()
        }
        .padding(.top, 18)
    }
}

struct InProgressCardView: View {
    var taskType: TasksType
    var taskTxt: String
    var percentage: Float
    private let maxBarWidth: CGFloat = 200
    var body: some View {
        RoundedRectangle(
            cornerSize: CGSize(width: 20, height: 20),
            style: .continuous
        )
        .foregroundStyle(taskType.color.opacity(0.15))
        .frame(width: 240, height: 140)
        .overlay {
            VStack(alignment: .leading) {
                HStack {
                    Text(taskType.name)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                    TaskTypeIcon(taskType: taskType)
                }
                Spacer()
                Text(taskTxt)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
                ZStack(alignment: .leading) {
                    RoundedRectangle(
                        cornerSize: CGSize(width: 10, height: 10),
                        style: .continuous
                    )
                    .frame(width: maxBarWidth, height: 10)
                    .foregroundStyle(.white)
                    RoundedRectangle(
                        cornerSize: CGSize(width: 10, height: 10),
                        style: .continuous
                    )
                    .frame(
                        width: (maxBarWidth
                            * CGFloat(
                                (percentage >= 0.0 && percentage <= 1.0)
                                    ? percentage : 0
                            )),
                        height: 10
                    )
                    .foregroundStyle(taskType.color)
                }
            }
            .padding()
        }
        .padding(.leading)
    }
}

struct TaskTypeData {
    let name: String
    let logoName: String
}

// MARK: Constants
enum TasksType: String {
    case officeProject
    case personalProject
    case dailyStudy

    var name: String {
        switch self {
        case .officeProject:
            return "Office Project"
        case .personalProject:
            return "Personal Project"
        case .dailyStudy:
            return "Daily Study"
        }
    }

    var imgName: String {
        switch self {
        case .officeProject:
            return "handbag.fill"
        case .personalProject:
            return "person.circle.fill"
        case .dailyStudy:
            return "book.fill"
        }
    }

    var color: Color {
        switch self {
        case .officeProject:
            return .blue
        case .personalProject:
            return .yellow
        case .dailyStudy:
            return .green
        }
    }

}

// MARK: Task Group Section View
extension HomeView {
    private var TaskGroupsSectionView: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionTitle(title: "Task Groups", numberOfTasks: 3)
            TaskGroupsCardView(
                percentage: 0.7,
                taskType: .dailyStudy,
                numberOfTasks: 21
            )
            TaskGroupsCardView(
                percentage: 0.5,
                taskType: .personalProject,
                numberOfTasks: 45
            )
            TaskGroupsCardView(
                percentage: 0.2,
                taskType: .officeProject,
                numberOfTasks: 34
            )
        }
        .padding(.bottom,80)
    }
}

struct TaskGroupsCardView: View {
    var percentage: CGFloat
    var taskType: TasksType
    var numberOfTasks: Int
    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerSize: CGSize(width: 20, height: 20),
                style: .continuous
            )
            .foregroundStyle(.black)
            HStack {
                TaskTypeIcon(taskType: taskType, width: 50, height: 50)
                VStack(alignment: .leading, spacing: 5) {
                    Text(taskType.name)
                        .font(.system(size: 18, weight: .medium))
                    Text("\(numberOfTasks) Tasks")
                        .font(.system(size: 16, weight: .light))
                }
                .padding(.leading, 5)
                Spacer()
                CircularProgressView(
                    percentage: Float(percentage),
                    taskType: taskType,
                    width: 65,
                    height: 65,
                    fontSize: 14,
                    strokeSize: 6
                )
            }
            .padding(.horizontal)
            .padding(.vertical, 2)
        }
        .padding(.horizontal)
        .shadow(color: .gray.opacity(0.1), radius: 10)
    }
}

// MARK: Custom Navigation Top Bar View
extension HomeView {
    private var CustomNavigationTopBarView: some View {
        HStack(spacing: 40) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading, spacing: 3) {
                    Text("Hello!")
                        .font(.system(size: 16))
                    Text(userName)
                        .font(.system(size: 18, weight: .semibold))
                        .lineLimit(1)
                }
            }
            Spacer()
            Image(systemName: "bell.fill")
                .resizable()
                .frame(width: 25, height: 25)
        }
        .padding(.horizontal, 25)
    }
}

// MARK: Progress Tracking View
extension HomeView {
    private var progressTrackingView: some View {
        ZStack {
            RoundedRectangle(
                cornerSize: CGSize(width: 35, height: 35),
                style: .circular
            )
            .fill(.mainPurple)

            HStack(spacing: 20) {
                TaskContentView(taskProgressTxt: taskProgressTxt) {
                    print(taskProgressTxt)
                }
                Spacer()
                CircularProgressView(percentage: percentage)
                CustomMenuButton {
                    print(percentage)
                }
            }
            .padding(20)
        }
        .frame(height: 170)
        .padding(.horizontal, 25)
        .padding(.top, 10)
    }
}

struct TaskContentView: View {
    var taskProgressTxt: String
    var onViewTaskTapped: (() -> Void)? = nil
    var body: some View {
        VStack(alignment: .leading) {
            Text(taskProgressTxt)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: 150)
                .lineLimit(3)
                .multilineTextAlignment(.leading)

            Spacer()

            RoundedRectangle(
                cornerSize: CGSize(width: 40, height: 40),
                style: .continuous
            )
            .frame(width: 120, height: 45)
            .foregroundStyle(.white)
            .overlay {
                Text("View Task")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.mainPurple)
            }
            .onTapGesture {
                if let action = onViewTaskTapped {
                    action()
                }
            }
        }
    }
}

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

// MARK: Custom Tab Bar
struct CustomTabView: View {
    let iconsNames: [String] = [
        "house.fill",
        "globe.americas.fill",
        "cloud.hail.fill",
        "plus",
        "person.fill",
    ]
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                UnevenRoundedRectangle(
                    topLeadingRadius: 20,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 20,
                    style: .circular
                )
                .fill(.thinMaterial)
                .ignoresSafeArea(edges: .all)
                .frame(height: 60)
                HStack(spacing: 45) {
                    ForEach(iconsNames, id: \.self) { iconName in
                        TabIcon(imgName: iconName)
                    }
                }
            }
        }
    }
}

struct TabIcon: View {
    let imgName: String
    var body: some View {
        Image(systemName: imgName)
            .resizable()
            .frame(
                width: 20,
                height: 20
            )
    }
}

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
