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
    
    var expensesByDate: [String: [Expense]] {
        guard !expenses.isEmpty else { return [:] }
        return .init(grouping: expenses, by: { $0.expenseDate })
    }
    
    init(expenseModel: ExpenseModel, expenseFetcher: ExpenseFetcher) {
        self.expenseModel = expenseModel
        self.expenseFetcher = expenseFetcher
        getCurrencies()
    }
    
    func getExpenses(for categoryId: Int?) {
        guard let safeCategoryId = categoryId else {
            isErrorAppeared = true
            errorAlertTitle = "Cannot fetch expenses for chosen category"
            errorMessage = "There occurs some error. Please try again."
            print("Error during fetching expenses for chosen category.")
            return
        }
        task = Task {
            do {
                expenses = try await expenseFetcher.getExpensesForCategory(id: safeCategoryId)
            } catch let error {
                print("Error during categories fetching: \(error.localizedDescription)")
            }
        }
    }
    
    func addExpense(for categoryId: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: selectedDate)
        task = Task {
            do {
                let isAdded = try await expenseFetcher.addExpenseToCategory(for: categoryId, name: expenseName, amount: convertedAmount, currency: currency, expenseDate: date, unnecessary: isOptional)
                isErrorAppeared = !isAdded
                getExpenses(for: categoryId)
            } catch let error {
                isErrorAppeared = true
                errorAlertTitle = "Cannot add expense"
                errorMessage = "There occurs some error during adding new category. Please try again."
                print("Error during creating new expense: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteExpense(for chosenCategory: Int, expenseId: Int) {task = Task {
            do {
                expenses = expenses.filter { $0.id != expenseId }
                let isDeleted = try await expenseFetcher.deleteExpense(categoryId: chosenCategory, expenseId: expenseId)
                isErrorAppeared = !isDeleted
                getExpenses(for: chosenCategory)
            } catch let error {
                isErrorAppeared = true
                errorMessage = "There occurs a problem during deleting chosen expense. Please try again."
                print("Error during deleting expense: \(error.localizedDescription)")
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
        stringExpenseDate = DateConverter.formatDate(for: date)
    }
}
