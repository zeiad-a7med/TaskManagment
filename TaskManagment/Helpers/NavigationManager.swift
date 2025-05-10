//
//  NavigationManager.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import Foundation
import SwiftData
import SwiftUI

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()  // Singleton instance
    @Published var path = NavigationPath()
    @Published var tab = TabBarItem.home.tag

    private init() {}  // Private initializer to enforce singleton pattern

    func push(_ target: RouteTypes) {
        switch target {
        case .home:
            popToRoot()
            tab = TabBarItem.home.tag
        case .tasks:
            popToRoot()
            tab = TabBarItem.calender.tag
        case .addProject:
            popToRoot()
            tab = TabBarItem.plus.tag
        case .todo:
            popToRoot()
            tab = TabBarItem.toDoList.tag
        case .profile:
            popToRoot()
            tab = TabBarItem.profile.tag
            
        case .loginChannels:
            path.append(target)
        case .loginWithEmail:
            path.append(target)

        default:
            path.append(target)
        }

    }
    
    
    func pushReplacement(_ target: RouteTypes) {
        path.removeLast()
        path.append(target)
    }
    func pop() {
        path.removeLast()
    }
    func popWithSize(_ size: Int) {
        path.removeLast(size)
    }
    func popToRoot() {
        path.removeLast(path.count)
    }
    func manageDestination(_ target: RouteTypes) -> AnyView {
        switch target {
        //Auth
        case .home:
            return AnyView(HomeView())
        case .tasks:
            return AnyView(EmptyView())
        case .addProject:
            return AnyView(EmptyView())
        case .todo:
            return AnyView(EmptyView())
        case .profile:
            return AnyView(EmptyView())
        case .loginChannels:
            return AnyView(LoginChannelsScreen())
        case .loginWithEmail:
            return AnyView(LoginWithEmailScreen())
        case .register:
            return AnyView(RegisterScreen())
        
//        default:
//            return AnyView(EmptyView())
        
        }
    }
}

enum RouteTypes: Hashable {
    //MainTabs
    case home
    case tasks
    case addProject
    case todo
    case profile
    //Auth
    case loginChannels
    case loginWithEmail
    case register
}
