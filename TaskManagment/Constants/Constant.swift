//
//  Constant.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import Foundation
import SwiftUICore

class Constant {
    static let backgroundBubble: [Bubble] = [
        Bubble(color: .yellow, x: 160, y: -420),
        Bubble(color: .green, x: -180, y: -220),
        Bubble(color: .blue, x: 190, y: -120),
        Bubble(color: .purple, x: -100, y: 80),
        Bubble(color: .red, x: 30, y: 400),
    ]

    // MARK: Home Page Sections
    enum HomePageSections {
        case middleSection
        case bottomSection

        var title: String {
            switch self {
            case .middleSection:
                return "In Progress"
            case .bottomSection:
                return "Task Groups"
            }
        }
    }

    // MARK: Custom Tab Bar Item
    static let customTabBarBackground:Material = .thinMaterial
}
