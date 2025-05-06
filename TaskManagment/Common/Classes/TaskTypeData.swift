//
//  TaskTypeData.swift
//  TaskManagment
//
//  Created by Usef on 05/05/2025.
//

import Foundation
import SwiftUICore

struct TaskTypeData {
    let name: String
    let logoName: String
}

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
