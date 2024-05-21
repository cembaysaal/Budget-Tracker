//
//  Category.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 21.05.2024.
//

import Foundation

struct Category: Identifiable, Codable {
    var id = UUID()
    var name: String
    var budget: Double
}
