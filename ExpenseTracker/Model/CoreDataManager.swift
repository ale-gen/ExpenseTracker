//
//  CoreDataManager.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 20/02/2022.
//

import Foundation
import CoreData

protocol CoreDataProtocol {
    static var instance: CoreDataManager { get }
    var container: NSPersistentContainer { get }
    var context: NSManagedObjectContext { get }
    func save()
}

protocol CategoryCoreDataProtocol {
    var categories: [ExpenseCategory] { get }
    func addCategory(name: String, icon: String)
    func deleteCategory(for indexSet: IndexSet)
    func editCategory(for category: ExpenseCategory, newName: String?, newIcon: String?)
    func fetchCategories()
}

class CoreDataManager: CoreDataProtocol {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private(set) var categories: [ExpenseCategory] = []
    
    init() {
        container = NSPersistentContainer(name: K.containerName)
        container.loadPersistentStores { description, error in
            if let caughtError = error {
                print("Error during loading data: \(caughtError)")
            }
        }
        
        context = container.viewContext
        fetchCategories()
    }
    
    func save() {
        do {
            try context.save()
            fetchCategories()
        } catch let error {
            print("Error during saving: \(error.localizedDescription)")
        }
    }
}

extension CoreDataManager: CategoryCoreDataProtocol {
    
    func addCategory(name: String, icon: String = K.noCategoryIcon) {
        let newCategory = ExpenseCategory(context: context)
        newCategory.name = name
        newCategory.icon = icon
        
        save()
    }
    
    func deleteCategory(for indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let deletedCategory = categories[index]
        context.delete(deletedCategory)
        save()
    }
    
    func editCategory(for category: ExpenseCategory, newName: String?, newIcon: String?) {
        let updatedCategory = category
        if let safeName = newName {
            updatedCategory.name = safeName
        }
        if let safeIcon = newIcon {
            updatedCategory.icon = safeIcon
        }
        category.name = updatedCategory.name
        category.icon = updatedCategory.icon
        
        return
    }
    
    func fetchCategories() {
        let request = NSFetchRequest<ExpenseCategory>(entityName: "ExpenseCategory")
        do {
            categories = try context.fetch(request)
        } catch let error {
            print("Error durig fetching categories: \(error.localizedDescription)")
        }
    }
}

