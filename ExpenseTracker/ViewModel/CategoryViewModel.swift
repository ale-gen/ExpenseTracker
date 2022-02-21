//
//  CategoryViewModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 20/02/2022.
//

import Foundation
import CoreData

class CategoryViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var categories: [ExpenseCategory] = []
    
    init() {
        categories = manager.categories
    }
    
    func addCategory(name: String, icon: String?) {
        if let userIcon = icon {
            manager.addCategory(name: name, icon: userIcon)
        } else {
            manager.addCategory(name: name)
        }
        categories = manager.categories
    }
    
    func deleteCategory(indexSet: IndexSet) {
        manager.deleteCategory(for: indexSet)
        categories = manager.categories
    }
    
    func updateCategory(for category: ExpenseCategory, name: String?, icon: String?) {
        manager.editCategory(for: category, newName: name, newIcon: icon)
        categories = manager.categories
    }
}
