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
    @Published var stringExpenseDate: String = DateConverter.getCurrentDate()
    
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
    
    func updateDate(for date: Date) {
        let day = DateConverter.getDay(for: date)
        let monthName = DateConverter.getMonthName(for: date)
        let expenseYear = DateConverter.getYear(for: date)
        let currentYear = DateConverter.getYear(for: Date.now)
        var convertedDate: String
        
        if expenseYear == currentYear {
            convertedDate = "\(day), \(monthName)"
        } else {
            convertedDate = "\(day), \(monthName) \(expenseYear)"
        }
        stringExpenseDate = convertedDate
    }
    
}
