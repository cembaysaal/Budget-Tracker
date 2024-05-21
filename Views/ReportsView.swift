//
//  ReportsView.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import SwiftUI
import DGCharts

struct ReportsView: View {
    @EnvironmentObject var transactionStore: TransactionStore
    @AppStorage("chartColor") private var chartColor: String = "default"

    var body: some View {
        NavigationView {
            VStack {
                PieChart(transactions: transactionStore.transactions, chartColor: chartColor)
                    .frame(height: 300)
                    .padding()
            }
            .navigationTitle("Reports")
        }
    }
}

struct PieChart: UIViewRepresentable {
    var transactions: [Transaction]
    var chartColor: String

    func makeUIView(context: Context) -> PieChartView {
        let chartView = PieChartView()
        chartView.holeColor = .clear
        return chartView
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        let groupedTransactions = Dictionary(grouping: transactions, by: { $0.category })
        let entries = groupedTransactions.map { (key, value) -> PieChartDataEntry in
            let total = value.reduce(0) { $0 + $1.amount }
            return PieChartDataEntry(value: total, label: key)
        }

        let dataSet = PieChartDataSet(entries: entries, label: "Categories")
        dataSet.colors = getColorScheme(for: chartColor)
        let data = PieChartData(dataSet: dataSet)
        uiView.data = data
    }

    private func getColorScheme(for scheme: String) -> [NSUIColor] {
        switch scheme {
        case "monochrome":
            return ChartColorTemplates.liberty()
        case "vibrant":
            return ChartColorTemplates.vordiplom() + ChartColorTemplates.joyful()
        default:
            return ChartColorTemplates.colorful()
        }
    }
}
