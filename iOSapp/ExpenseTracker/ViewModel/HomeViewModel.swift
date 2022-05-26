//
//  HomeViewModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 25/05/2022.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    private var categoryFetcher: CategoryFetcher
    private var task: Task<(), Never>?
    private var categories: [ExpenseCategory] = []
    private var expenses: [Expense] = []
    
    @Published var dailyExpenses: [String: [Double]] = [:]
    @Published var availableChoices: [String] = []
    
    init(categoryFetcher: CategoryFetcher) {
        self.categoryFetcher = categoryFetcher
        fetchCategories()
    }
    
    func fetchCategories() {
        task = Task {
            do {
                categories = try await categoryFetcher.getAll()
                extractExpenses()
            } catch {
                print("Cannot fetch categories")
            }
        }
    }
    
    func extractExpenses() {
        expenses = []
        for category in categories {
            expenses.append(contentsOf: category.expenses)
        }
        groupExpensesByMonth()
    }
    
    func groupExpensesByMonth() {
        let expensesDetailsByExpenseDate = Dictionary(grouping: expenses, by: { $0.expenseDate })
        expensesDetailsByExpenseDate.forEach { date, expenses in
            if let (expenseDay, expenseMonth, expenseYear) = DateConverter.extractDate(stringDate: date) {
                var key: String
                let expenseMonthAbb = DateFormatter().shortMonthSymbols[expenseMonth - 1]
                if expenseYear == Int(DateConverter.getLongYear(for: Date.now)) {
                    key = expenseMonthAbb
                } else {
                    key = "\(expenseYear % 100), \(expenseMonthAbb)"
                }
                if dailyExpenses[key] == nil {
                    let daysNumberForExpenseMonth = expenseMonth.getDaysNumber(year: expenseYear)
                    dailyExpenses[key] = Array(repeating: 0, count: daysNumberForExpenseMonth)
                }
                var dailySum = 0.0
                for expense in expenses {
                    dailySum += expense.amount
                }
                self.dailyExpenses[key]?.remove(at: expenseDay - 1)
                self.dailyExpenses[key]?.insert(dailySum, at: expenseDay - 1)
            }
        }
        updateAvailableChoices()
    }
    
    func updateAvailableChoices() {
        availableChoices = []
        for key in dailyExpenses.keys {
            availableChoices.append(key)
        }
    }
    
}
