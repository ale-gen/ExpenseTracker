//
//  CategoryViewModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 20/02/2022.
//

import Foundation
import CoreData

class CategoryViewModel: ObservableObject {
    
    private var categoryFetcher: CategoryFetcher
    private var emojiFetcher: EmojiFetcher
    private var task: Task<(), Never>?
    
    @Published var categories: [ExpenseCategory] = []
    @Published var emojis: [Emoji] = []
    @Published var isLoading: Bool = false
    
    init(categoryFetcher: CategoryFetcher, emojiFetcher: EmojiFetcher) {
        self.categoryFetcher = categoryFetcher
        self.emojiFetcher = emojiFetcher
    }
    
    var expensesForCategory: [String: Int] {
        return categories.reduce([String: Int]()) { (dict, category) -> [String: Int] in
            var dict = dict
            dict[category.name] = category.expenses.count
            return dict
        }
    }
    
    @MainActor
    func getCategories() {
        task = Task {
            isLoading = true
            do {
                categories = try await categoryFetcher.getAll()
            } catch let error {
                print("Error during categories fetching: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
    
    //    func addCategory(name: String, icon: String?) {
    //        if let userIcon = icon {
    //            manager.addCategory(name: name, icon: userIcon)
    //        } else {
    //            manager.addCategory(name: name)
    //        }
    //        categories = manager.categories
    //    }
    //
    //    func deleteCategory(indexSet: IndexSet) {
    //        manager.deleteCategory(for: indexSet)
    //        categories = manager.categories
    //    }
    //
    //    func updateCategory(for category: ExpenseCategory, name: String?, icon: String?) {
    //        manager.editCategory(for: category, newName: name, newIcon: icon)
    //        categories = manager.categories
    //    }
    
    @MainActor
    func getAllEmojis() {
        task = Task {
            do {
                isLoading = true
                emojis = try await emojiFetcher.getAll()
            } catch let error {
                print("Error during emoji fetching: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
}
