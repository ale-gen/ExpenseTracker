//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 25/02/2022.
//

import Foundation
import CoreData

public class Expense: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var category: ExpenseCategory
    @NSManaged var amount: Double
    @NSManaged var currency: String
    @NSManaged var date: Date
    @NSManaged var unnecessary: Bool
}
