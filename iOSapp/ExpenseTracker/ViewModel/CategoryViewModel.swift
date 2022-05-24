//
//  CategoryViewModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 20/02/2022.
//

import Foundation

@MainActor
class CategoryViewModel: ObservableObject {
    
    private var categoryFetcher: CategoryFetcher
    private var emojiFetcher: EmojiFetcher
    private var task: Task<(), Never>?
    
    @Published var categories: [ExpenseCategory] = []
    @Published var emojis: [Emoji] = []
    @Published var isLoading: Bool = false
    @Published var chosenCategory: String = ""
    
    @Published var isErrorAppeared: Bool = false
    @Published var errorAlertTitle: String = ""
    @Published var errorMessage: String = ""
    
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
    
    func addCategory(name: String, userIcon: String = K.noCategoryIcon) {
        task = Task {
            do {
                let isAdded = try await categoryFetcher.addCategory(name: name, icon: userIcon)
                isErrorAppeared = !isAdded
                self.getCategories()
            } catch let error {
                isErrorAppeared = true
                errorAlertTitle = "Cannot add category"
                errorMessage = "There occurs some error during adding new category. Please try again."
                print("Error during creating category: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteCategory(indexSet: IndexSet) {
        let idToDelete = indexSet.map { categories[$0].id }
        
        guard idToDelete.count == 1 else {
            isErrorAppeared = true
            errorAlertTitle = "Cannot delete category"
            errorMessage = "Number of chosen categories is not correct. Please try again."
            return
        }
        
        task = Task {
            do {
                for index in indexSet {
                    categories.remove(at: index)
                }
                let isDeleted = try await categoryFetcher.deleteCategory(id: idToDelete[0])
                self.getCategories()
                isErrorAppeared = !isDeleted
            } catch let error {
                isErrorAppeared = true
                errorMessage = "There occurs a problem during deleting chosen category. Please try again."
                print("Error during deleting category: \(error.localizedDescription)")
            }
        }
    }
    
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
    
    func getEmojisForChosenCategory() {
        task = Task {
            do {
                isLoading = true
                emojis = try await emojiFetcher.getByCategory(for: chosenCategory)
            } catch let error {
                print("Error during emoji for chosen category fetching: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
}
