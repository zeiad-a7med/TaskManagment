//
//  CustomTabBarContainerView.swift
//  TaskManagment
//
//  Created by Usef on 06/05/2025.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = []
    let content: Content
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    var body: some View {
        ZStack (alignment: .bottom){
            content
                .edgesIgnoringSafeArea(.bottom)
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection) {
                print("tappedddddd!")
            }
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self , perform: { value in
            self.tabs = value
        })
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [.home, .plus, .profile]
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
