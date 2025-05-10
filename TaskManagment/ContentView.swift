//
//  ContentView.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var navigationManager = NavigationManager.shared
    @Query private var items: [Item]

    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            AppTabBarView()
                .navigationDestination(for: RouteTypes.self) { target in
                    NavigationManager.shared.manageDestination(target)
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
