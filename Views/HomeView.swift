//
//  HomeView.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("monthlyBudget") private var monthlyBudget: Double = 2000
    @AppStorage("showBudgetSummary") private var showBudgetSummary: Bool = true
    @AppStorage("showRecentTransactions") private var showRecentTransactions: Bool = true
    @AppStorage("currency") private var currency: String = "USD"
    @EnvironmentObject var transactionStore: TransactionStore

    var totalExpenses: Double {
        transactionStore.transactions.reduce(0) { $0 + $1.amount }
    }

    var remainingBudget: Double {
        monthlyBudget - totalExpenses
    }

    var body: some View {
        NavigationView {
            VStack {
                if showBudgetSummary {
                    BudgetSummaryView(totalExpenses: totalExpenses, remainingBudget: remainingBudget, monthlyBudget: monthlyBudget, currency: currency)
                        .padding(.bottom, 20)
                }
                if showRecentTransactions {
                    RecentTransactionsView(transactions: $transactionStore.transactions, currency: currency)
                }
            }
            .navigationTitle("Home")
            .navigationBarItems(trailing: NavigationLink(destination: HomeSettingsView()) {
                Image(systemName: "gearshape")
            })
        }
    }
}

struct RecentTransactionsView: View {
    @Binding var transactions: [Transaction]
    var currency: String

    var body: some View {
        List(transactions) { transaction in
            HStack {
                VStack(alignment: .leading) {
                    Text(transaction.category)
                        .font(.headline)
                    Text(transaction.description)
                        .font(.subheadline)
                }
                Spacer()
                Text(NumberFormatter.currency(for: currency).string(from: NSNumber(value: transaction.amount)) ?? "")
                    .font(.headline)
            }
        }
    }
}

struct HomeSettingsView: View {
    @AppStorage("showBudgetSummary") private var showBudgetSummary: Bool = true
    @AppStorage("showRecentTransactions") private var showRecentTransactions: Bool = true

    var body: some View {
        Form {
            Toggle("Show Budget Summary", isOn: $showBudgetSummary)
            Toggle("Show Recent Transactions", isOn: $showRecentTransactions)
        }
        .navigationTitle("Home Settings")
    }
}
