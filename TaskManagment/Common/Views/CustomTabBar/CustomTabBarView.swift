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
    @State var localSelection: TabBarItem
    var plusAction: (() -> Void)
    var body: some View {
        tabBarVersion3
            .onChange(of: selection) { oldValue, newValue in
                withAnimation (.easeInOut) {
                    localSelection = newValue
                }
            }
    }
    private func switchToTab(tab: TabBarItem) {
            selection = tab
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [.home, .plus, .profile]
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!) {
                print("Tapped!!")
            }
        }
    }
}

// MARK: Tab Version2
extension CustomTabBarView {
    private func tabView2(tab: TabBarItem) -> some View {
        VStack(spacing: 0) {
            Image(systemName: tab.iconName)
                .font(.system(size: 18, weight: .medium))
                .symbolVariant(localSelection == tab ? .fill : .none)
        }
        .foregroundColor(localSelection == tab ? tab.color : .gray.opacity(0.8))
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {  
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 30)
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
        ZStack {
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
            
            Button {
                plusAction()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding()
                    .background(.mainPurple)
                    .clipShape(Circle())
                    .shadow(color: .mainPurple.opacity(0.25), radius: 10)
            }
            .offset(y: -25)

        }
    }
}

struct TabBarBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius: CGFloat = 35
        let center = rect.midX
        var path = Path()

        // Start from left
        path.move(to: CGPoint(x: 0, y: 0))

        // Line to start of notch
        path.addLine(to: CGPoint(x: center - radius * 2, y: 0))

        // Curve into notch
        path.addQuadCurve(
            to: CGPoint(x: center - radius, y: radius),
            control: CGPoint(x: center - radius * 1.5, y: 0)
        )

        // Arc (the notch)
        path.addArc(center: CGPoint(x: center, y: radius),
                    radius: radius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0),
                    clockwise: false)

        // Curve out of notch
        path.addQuadCurve(
            to: CGPoint(x: center + radius * 2, y: 0),
            control: CGPoint(x: center + radius * 1.5, y: 0)
        )

        // Continue to right side
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}

extension CustomTabBarView {
    private var tabBarVersion3: some View {
        ZStack(alignment: .bottom) {
            TabBarBackgroundShape()
                .fill(Constant.customTabBarBackground)
                            .shadow(radius: 5)
                            .ignoresSafeArea()
                            .frame(height: 55)
            
            HStack(spacing: 10) {
                ForEach(tabs.prefix(2), id: \.self) { tab in
                    tabView2(tab: tab)
                        .onTapGesture {
                            switchToTab(tab: tab)
                        }
                }
                
                Spacer()
                    .frame(width: 80)
            
                ForEach(tabs.suffix(2), id: \.self) { tab in
                    tabView2(tab: tab)
                        .onTapGesture {
                            switchToTab(tab: tab)
                        }
                }
            }
            .padding(8)
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 4)
            
            // Floating center button
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 70,height: 70)
                Button {
                    plusAction()
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(.mainPurple)
                        .clipShape(Circle())
                        .shadow(color: .mainPurple.opacity(0.25), radius: 10)
                }
            }
            .offset(y: -10)
        }
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
        .foregroundStyle(localSelection == tab ? tab.color : Color.gray)
        .padding()
        .frame(maxWidth: .infinity)
        .background(localSelection == tab ? tab.color.opacity(0.25) : Color.clear)
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
