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
    @Published var tab = 0

    private init() {}  // Private initializer to enforce singleton pattern

    func push(_ target: RouteTypes) {
        switch target {
//        case .home:
//            popToRoot()
//            tab = 0
//        case .categories:
//            popToRoot()
//            tab = 1
//        case .orders:
//            popToRoot()
//            tab = 2
//        case .settings:
//            popToRoot()
//            tab = 3
        

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
    //Auth
    case loginChannels
    case loginWithEmail
    case register
}
