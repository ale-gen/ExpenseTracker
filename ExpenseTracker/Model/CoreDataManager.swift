//
//  CoreDataManager.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 20/02/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    var categories: [ExpenseCategory] = []
    
    init() {
        container = NSPersistentContainer(name: "ExpenseTracker")
        container.loadPersistentStores { description, error in
            if let caughtError = error {
                print("Error during loading data: \(caughtError)")
            }
        }
        
        context = container.viewContext
        fetchCategories()
    }
    
    func addCategory(name: String, icon: String = K.noCategoryIcon) {
        let newCategory = ExpenseCategory(context: context)
        newCategory.name = name
        newCategory.icon = icon
        
        save()
    }
    
    func fetchCategories() {
        let request = NSFetchRequest<ExpenseCategory>(entityName: "ExpenseCategory")
        do {
            categories = try context.fetch(request)
        } catch let error {
            print("Error durig fetching categories: \(error.localizedDescription)")
        }
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
