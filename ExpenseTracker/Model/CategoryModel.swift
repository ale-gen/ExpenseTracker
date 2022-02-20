//
//  CategoryModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 20/02/2022.
//

import Foundation
import CoreData

protocol categoryModel {
    func addCategory(name: String, icon: String?)
}

class CategoryModel: categoryModel {
    func addCategory(name: String, icon: String?) {
//        let newCategory = ExpenseCategory(context: viewContext)
    }
}
