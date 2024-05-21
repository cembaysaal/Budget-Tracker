//
//  BudgetSummaryView.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import SwiftUI

struct BudgetSummaryView: View {
    var totalExpenses: Double
    var remainingBudget: Double
    var monthlyBudget: Double
    var currency: String

    var body: some View {
        HStack {
            budgetSection(title: "Monthly Budget", amount: monthlyBudget)
            Spacer()
            budgetSection(title: "Total Expenses", amount: totalExpenses)
            Spacer()
            budgetSection(title: "Remaining", amount: remainingBudget)
        }
        .padding()
    }

    private func budgetSection(title: String, amount: Double) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(NumberFormatter.currency(for: currency).string(from: NSNumber(value: amount)) ?? "")
                .font(.title)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

extension NumberFormatter {
    static func currency(for code: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = code
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
}
