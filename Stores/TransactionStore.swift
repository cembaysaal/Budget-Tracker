//
//  TransactionStore.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import SwiftUI

class TransactionStore: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
    
    func updateTransaction(_ transaction: Transaction) {
        if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
            transactions[index] = transaction
        }
    }
}
