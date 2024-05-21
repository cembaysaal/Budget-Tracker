//
//  BudgetTrackerApp.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import SwiftUI

@main
struct BudgetTrackerApp: App {
    @StateObject private var transactionStore = TransactionStore()
    @StateObject private var categoryStore = CategoryStore()
    @AppStorage("theme") private var theme: String = "Light"

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .environmentObject(transactionStore)
                    .environmentObject(categoryStore)

                TransactionsView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Transactions")
                    }
                    .environmentObject(transactionStore)
                    .environmentObject(categoryStore)

                ReportsView()
                    .tabItem {
                        Image(systemName: "chart.pie")
                        Text("Reports")
                    }
                    .environmentObject(transactionStore)

                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }

                CategoriesView()
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("Categories")
                    }
                    .environmentObject(categoryStore)
            }
            .preferredColorScheme(theme == "Light" ? .light : .dark)
        }
    }
}
