//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    
    private var expenseModel: ExpenseModel
    
    @Published var inputExpenseAmount: String = ""
    @Published var currencies: [String] = []
    
    init(expenseModel: ExpenseModel) {
        self.expenseModel = expenseModel
        getCurrencies()
    }
    
    func validAmountInput(for input: String) {
        inputExpenseAmount = NumbersOnly.filterNumbers(for: input)
    }
    
    func getCurrencies() {
        currencies = expenseModel.currencies
    }
    
}
