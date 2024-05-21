//
//  Transaction.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 21.05.2024.
//

import Foundation

struct Transaction: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var amount: Double
    var category: String
    var description: String
}
