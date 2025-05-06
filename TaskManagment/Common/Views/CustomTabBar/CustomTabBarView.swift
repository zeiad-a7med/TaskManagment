//
//  AppTabBarView.swift
//  TaskManagment
//
//  Created by Usef on 05/05/2025.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Namespace private var namespace
    @Binding var selection: TabBarItem

    var body: some View {
        tabBarVersion2
    }
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [.home, .plus, .profile]
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!))
        }
    }
}

// MARK: Tab Version2
extension CustomTabBarView {
    private func tabView2(tab: TabBarItem) -> some View {
        VStack(spacing: 4) {
            Image(systemName: tab.iconName)
                .font(.system(size: 18, weight: .medium))
                .symbolVariant(selection == tab ? .fill : .none) 
        }
        .foregroundColor(selection == tab ? tab.color : .gray.opacity(0.8))
        .padding(.vertical, 10)  
        .frame(maxWidth: .infinity)
        .background(
            ZStack {  
                if selection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(
                            id: "background_rectangle",
                            in: namespace
                        )
                }
            }
        )
        .contentShape(Rectangle())
        .animation(
            .interactiveSpring(response: 0.25, dampingFraction: 0.7),
            value: selection
        )
    }

    private var tabBarVersion2: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            selection = tab
                        }
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }
            }
        }
        .padding(8)
        .background(
            Constant.customTabBarBackground
        )
        .cornerRadius(12)
        .shadow(
            color: .black.opacity(0.15),
            radius: 10,
            x: 0,
            y: 4
        )
        .padding(.horizontal, 16)
    }
}

// MARK: Tab Version1
extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack(spacing: 2) {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 9, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(selection == tab ? tab.color : Color.gray)
        .padding()
        .frame(maxWidth: .infinity)
        .background(selection == tab ? tab.color.opacity(0.25) : Color.clear)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 40, height: 40)))
    }

    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Constant.customTabBarBackground)
    }
}
