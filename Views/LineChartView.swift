//
//  LineChartView.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 21.05.2024.
//

import SwiftUI
import DGCharts

struct LineChart: UIViewRepresentable {
    var transactions: [Transaction]

    func makeUIView(context: Context) -> LineChartView {
        let chartView = LineChartView()
        return chartView
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        let sortedTransactions = transactions.sorted(by: { $0.date < $1.date })
        let entries = sortedTransactions.map { transaction in
            return ChartDataEntry(x: transaction.date.timeIntervalSince1970, y: transaction.amount)
        }

        let dataSet = LineChartDataSet(entries: entries, label: "Expenses Over Time")
        dataSet.colors = [NSUIColor.blue]
        let data = LineChartData(dataSet: dataSet)
        uiView.data = data
    }
}
