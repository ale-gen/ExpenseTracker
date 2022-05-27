//
//  ExpenseFetcher.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 06/05/2022.
//

import Foundation

protocol ExpenseFetcherProtocol {
    func getAll() async throws -> [Expense]
}

class ExpenseFetcher: ExpenseFetcherProtocol, RequestProtocol {
    private let session: URLSession
    private let urlString = "\(K.baseUrl)/api/expenses"
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func getAll() async throws -> [Expense] {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: "GET")
        let (data, _) = try await session.data(for: request)
        guard let expenses = try? JSONDecoder().decode([Expense].self, from: data) else { throw NetworkError.invalidData }
        return expenses
    }
    
    func getExpensesForCategory(id: Int) async throws -> [Expense] {
        let expensesForCategoryUrl = "\(urlString)/categoryId=\(id)"
        guard let url = URL(string: expensesForCategoryUrl) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: "GET")
        let (data, _) = try await session.data(for: request)
        guard let expenses = try? JSONDecoder().decode([Expense].self, from: data) else { throw NetworkError.invalidData }
        return expenses
    }
    
    func addExpenseToCategory(for categoryId: Int?, name: String, amount: Double, currency: String, expenseDate: String, unnecessary: Bool) async throws -> Bool {
        guard let id = categoryId else { throw NetworkError.invalidData }
        let newExpenseUrlString = "\(urlString)/categoryId=\(id)"
        guard let url = URL(string: newExpenseUrlString) else { throw NetworkError.invalidURL }
        let postBody = ["name": name, "amount": amount, "currency": currency, "expenseDate": expenseDate, "unnecessary": unnecessary] as [String : Any]
        let request = createRequest(url: url, method: "POST", postBody: postBody)
        let (_, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                return true
            default:
                throw NetworkError.unknown
            }
        }
        return false
    }
    
    func deleteExpense(categoryId: Int, expenseId: Int) async throws -> Bool {
        let deletingUrl = "\(urlString)/categoryId=\(categoryId)/expenseId=\(expenseId)"
        guard let url = URL(string: deletingUrl) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: "DELETE")
        let (_, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                return true
            default:
                throw NetworkError.unknown
            }
        }
        return false
    }
}
