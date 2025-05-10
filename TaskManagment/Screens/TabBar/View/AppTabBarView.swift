//
//  AppTabBarView.swift
//  TaskManagment
//
//  Created by Usef on 05/05/2025.
//

import SwiftUI

struct AppTabBarView: View {
    @State private var tabSelection:TabBarItem = .home
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            HomeView()
                .tag(TabBarItem.home.tag)
                .tabBarItem(tab: .home, selection: $tabSelection)
    
            
            Color.yellow
                .tag(TabBarItem.calender.tag)
                .tabBarItem(tab: .calender, selection: $tabSelection)
            
            Color.red
                .tag(TabBarItem.toDoList.tag)
                .tabBarItem(tab: .toDoList, selection: $tabSelection)
            
            Color.brown
                .tag(TabBarItem.profile.tag)
                .tabBarItem(tab: .profile, selection: $tabSelection)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: tabSelection)
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}
