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
    func deleteCategory(name: String)
    func editCategory(name: String)
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
    
    func deleteCategory(name: String) {
        //MARK: - TODO: DELETE
        return
    }
    
    func editCategory(name: String) {
        //MARK: - TODO: EDIT
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

