//
//  CategoryStore.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import SwiftUI

class CategoryStore: ObservableObject {
    @Published var categories: [Category] = []
}
