//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import Foundation
import CoreData

class ExpenseViewModel: ObservableObject {
    
    private var expenseModel: ExpenseModel
    let manager = CoreDataManager.instance
    static let sharedInstance = ExpenseViewModel(expenseModel: ExpenseModel())
    private var task: Task<(), Never>?
    
    @Published var expenses: [Expense] = []
    @Published var inputExpenseAmount: String = ""
    @Published var currencies: [String] = []
    @Published var stringExpenseDate: String = DateConverter.getCurrentDate()
    
    private var convertedAmount: Double {
        return Double(inputExpenseAmount) ?? 0.0
    }
    
    init(expenseModel: ExpenseModel) {
        self.expenseModel = expenseModel
        expenses = manager.expenses
        getCurrencies()
    }
    
    func addExpense(name: String, category: ExpenseCategory, currency: String, unnecessary: Bool) {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: stringExpenseDate) ?? Date.now
        manager.addExpense(name: name, amount: convertedAmount, currency: currency, unnecessary: unnecessary, expenseDate: date)
        expenses = manager.expenses
    }
    
    func deleteExpense(indexSet: IndexSet) {
        manager.deleteExpense(for: indexSet)
        expenses = manager.expenses
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
