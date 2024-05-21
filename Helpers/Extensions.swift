//
//  Extensions.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import Foundation

extension Double {
    var formattedCurrency: String {
        return String(format: "$%.2f", self)
    }
}
