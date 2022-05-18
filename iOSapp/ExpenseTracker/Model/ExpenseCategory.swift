//
//  ExpenseCategory.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 19/02/2022.
//

import Foundation

struct ExpenseCategory: Decodable, Hashable {
    let id: Int
    let name: String
    let icon: String?
    let expenses: [Expense]
    
    static func == (lhs: ExpenseCategory, rhs: ExpenseCategory) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
