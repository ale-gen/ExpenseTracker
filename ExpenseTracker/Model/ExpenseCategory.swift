//
//  ExpenseCategory.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 19/02/2022.
//

import Foundation
import CoreData

public class ExpenseCategory: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var icon: String
}
