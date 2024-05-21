//
//  CategoriesView.swift
//  BudgetTracker
//
//  Created by Cem Baysal on 14.05.2024.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var categoryStore: CategoryStore
    @State private var newCategoryName = ""
    @State private var newCategoryBudget = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add New Category")) {
                        TextField("Category Name", text: $newCategoryName)
                        TextField("Category Budget", text: $newCategoryBudget)
                            .keyboardType(.decimalPad)
                        Button(action: addCategory) {
                            Text("Add Category")
                        }
                    }
                }
                List {
                    ForEach(categoryStore.categories) { category in
                        HStack {
                            Text(category.name)
                            Spacer()
                            Text("$\(category.budget, specifier: "%.2f")")
                        }
                    }
                    .onDelete(perform: deleteCategory)
                }
            }
            .navigationTitle("Categories")
        }
    }

    private func addCategory() {
        if let budget = Double(newCategoryBudget), !newCategoryName.isEmpty {
            let newCategory = Category(name: newCategoryName, budget: budget)
            categoryStore.categories.append(newCategory)
            newCategoryName = ""
            newCategoryBudget = ""
        }
    }

    private func deleteCategory(at offsets: IndexSet) {
        categoryStore.categories.remove(atOffsets: offsets)
    }
}
