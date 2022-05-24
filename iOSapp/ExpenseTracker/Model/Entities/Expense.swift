//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 25/02/2022.
//

import Foundation

struct Expense: Decodable {
    let id: Int
    let name: String
    let amount: Double
    let currency: String
    let expenseDate: String
    let unnecessary: Bool
}
