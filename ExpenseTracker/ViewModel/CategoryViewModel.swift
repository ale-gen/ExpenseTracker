//
//  CategoryViewModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 20/02/2022.
//

import Foundation
import CoreData

@MainActor
class CategoryViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    private var emojiFetcher: EmojiFetcher
    private var task: Task<(), Never>?
    
    @Published var categories: [ExpenseCategory] = []
    @Published var emojis: [Emoji] = []
    
    init(fetcher: EmojiFetcher) {
        categories = manager.categories
        emojiFetcher = fetcher
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
    
    func getAllEmojis() {
        task = Task {
            do {
                emojis = try await emojiFetcher.getAll()
            } catch let error {
                print("Error during emoji fetching: \(error.localizedDescription)")
            }
        }
    }
}
