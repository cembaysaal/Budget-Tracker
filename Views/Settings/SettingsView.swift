//
//  SettingsView.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("monthlyBudget") private var monthlyBudget: Double = 2000
    @AppStorage("theme") private var theme: String = "Light"
    @AppStorage("currency") private var currency: String = "USD"
    @AppStorage("chartColor") private var chartColor: String = "default"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Budget")) {
                    TextField("Monthly Budget", value: $monthlyBudget, formatter: NumberFormatter.currency(for: currency))
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Currency")) {
                    Picker("Currency", selection: $currency) {
                        Text("Dollar").tag("USD")
                        Text("Euro").tag("EUR")
                        Text("Turkish Lira").tag("TRY")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Theme")) {
                    Picker("Theme", selection: $theme) {
                        Text("Light").tag("Light")
                        Text("Dark").tag("Dark")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Chart Color")) {
                    Picker("Chart Color", selection: $chartColor) {
                        Text("Default").tag("default")
                        Text("Monochrome").tag("monochrome")
                        Text("Vibrant").tag("vibrant")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Settings")
        }
    }
}
