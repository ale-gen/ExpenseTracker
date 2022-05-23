//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import Foundation

@MainActor
class ExpenseViewModel: ObservableObject {
    
    private var expenseModel: ExpenseModel
    private var expenseFetcher: ExpenseFetcher
    private var task: Task<(), Never>?
    
    @Published var expenses: [Expense] = []
    @Published var currencies: [String] = []
    @Published var stringExpenseDate: String = DateConverter.getCurrentDate()
    
    @Published var expenseName: String = ""
    @Published var expenseAmount: String = ""
    @Published var selectedCurrency: Int = 0
    @Published var isOptional: Bool = false
    @Published var selectedDate: Date = Date.now
    
    @Published var isErrorAppeared: Bool = false
    @Published var errorAlertTitle: String = ""
    @Published var errorMessage: String = ""
    
    private var convertedAmount: Double {
        return Double(expenseAmount) ?? 0.0
    }
    
    private var currency: String {
        return currencies[selectedCurrency]
    }
    
    init(expenseModel: ExpenseModel, expenseFetcher: ExpenseFetcher) {
        self.expenseModel = expenseModel
        self.expenseFetcher = expenseFetcher
        getCurrencies()
    }
    
    func addExpense(for categoryId: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: selectedDate)
        task = Task {
            do {
                let isAdded = try await expenseFetcher.addExpenseToCategory(for: categoryId, name: expenseName, amount: convertedAmount, currency: currency, expenseDate: date, unnecessary: isOptional)
                isErrorAppeared = !isAdded
            } catch let error {
                isErrorAppeared = true
                errorAlertTitle = "Cannot add expense"
                errorMessage = "There occurs some error during adding new category. Please try again."
                print("Error during creating new expense: \(error.localizedDescription)")
            }
        }
    }
    
    func validAmountInput(for input: String) {
        expenseAmount = NumbersOnly.filterNumbers(for: input)
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
