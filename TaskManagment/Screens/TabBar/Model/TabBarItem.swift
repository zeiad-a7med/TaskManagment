//
//  TabBarItem.swift
//  TaskManagment
//
//  Created by Usef on 06/05/2025.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home
    case calender
    case plus
    case toDoList
    case profile
    
    var iconName: String {
        switch self {
        case .home:
            return "house.fill"
        case .calender:
            return "globe.americas.fill"
        case .plus:
            return "plus"
        case .toDoList:
            return "cloud.hail.fill"
        case .profile:
            return "person.fill"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .calender:
            return "Calender"
        case .plus:
            return "Plus"
        case .toDoList:
            return "ToDoList"
        case .profile:
            return "Profile"
        }
    }
    
    var tag: Int {
        switch self {
        case .home:
            return 0
        case .calender:
            return 1
        case .plus:
            return 2
        case .toDoList:
            return 3
        case .profile:
            return 4
        }
    }
    
    var color: Color {
        .mainPurple
    }
}
