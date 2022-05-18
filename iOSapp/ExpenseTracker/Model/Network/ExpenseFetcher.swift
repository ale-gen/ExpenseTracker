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
}
