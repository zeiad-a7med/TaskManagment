//
//  pagingSubView.swift
//  M-Commerce-App
//
//  Created by Usef on 24/02/2025.
//

import SwiftUI

struct pagingSubView: View {
    private let imgArray = ["onboarding", "onboarding2", "onboarding"]
    private let textArray = [
        "Task Managment \n& To-Do List",
        "Task Managment & To-Do List",
        "Task Managment & To-Do List",
    ]
    private let descArray =
        [
            "This productive tool is designed to help you better manage your task project-wise conveniently!",
            "This productive tool is designed to help you better manage your task project-wise conveniently!",
            "This productive tool is designed to help you better manage your task project-wise conveniently!",
        ]
    private let pageCount = 3
    @State private var currentIndex = 0
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<pageCount, id: \.self) { index in
                BoardingPage(
                    imgName: imgArray[index],
                    text: textArray[index],
                    desc: descArray[index]
                )
                .tag(index)
                .tabItem {
                    Label("Home", image: "heart.fill")
                }
            }
        }.offset(y: -90)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.width * 1.5
            )
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(
                HStack(spacing: 10) {
                    ForEach(0..<pageCount, id: \.self) {
                        index in
                        Capsule()
                            .fill(
                                index == currentIndex
                                ? .mainPurple : .secondary
                            )
                            .frame(width: currentIndex == index ? 25 : 10, height: 10)
                            .animation(.easeInOut(duration: 0.3), value: currentIndex)
                    }
                }.padding(
                .bottom,
                UIApplication.shared.windows.first?.safeAreaInsets.bottom),
                alignment: .bottom
            )
    }
}

#Preview {
    pagingSubView()
}
