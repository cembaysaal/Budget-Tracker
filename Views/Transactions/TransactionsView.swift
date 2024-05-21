//
//  TransactionsView.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import SwiftUI

struct TransactionsView: View {
    @EnvironmentObject var transactionStore: TransactionStore
    @EnvironmentObject var categoryStore: CategoryStore
    @State private var showingAddTransaction = false
    @State private var selectedTransaction: Transaction?
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            List {
                ForEach(transactionStore.transactions) { transaction in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(transaction.category)
                                .font(.headline)
                            Text(transaction.description)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("$\(transaction.amount, specifier: "%.2f")")
                            .font(.headline)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedTransaction = transaction
                        isEditing = true
                        showingAddTransaction = true
                    }
                }
                .onDelete(perform: transactionStore.deleteTransaction)
            }
            .navigationTitle("Transactions")
            .navigationBarItems(trailing: Button(action: {
                selectedTransaction = nil
                isEditing = false
                showingAddTransaction.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddTransaction) {
                AddTransactionView(transaction: $selectedTransaction, isEditing: $isEditing)
                    .environmentObject(transactionStore)
                    .environmentObject(categoryStore)
            }
        }
    }
}

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var transactionStore: TransactionStore
    @EnvironmentObject var categoryStore: CategoryStore

    @Binding var transaction: Transaction?
    @Binding var isEditing: Bool

    @State private var date = Date()
    @State private var amount = ""
    @State private var category = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                Picker("Category", selection: $category) {
                    ForEach(categoryStore.categories) { category in
                        Text(category.name).tag(category.name)
                    }
                }
                TextField("Description", text: $description)
            }
            .onAppear {
                if let transaction = transaction {
                    date = transaction.date
                    amount = "\(transaction.amount)"
                    category = transaction.category
                    description = transaction.description
                }
            }
            .navigationTitle(isEditing ? "Edit Transaction" : "Add Transaction")
            .navigationBarItems(trailing: Button("Save") {
                if let amount = Double(amount) {
                    let newTransaction = Transaction(id: transaction?.id ?? UUID(), date: date, amount: amount, category: category, description: description)
                    if isEditing {
                        transactionStore.updateTransaction(newTransaction)
                    } else {
                        transactionStore.transactions.append(newTransaction)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}
