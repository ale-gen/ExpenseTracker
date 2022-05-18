//
//  CategoryFetcher.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 06/05/2022.
//

import Foundation

protocol CategoryFetcherProtocol {
    func getAll() async throws -> [ExpenseCategory]
}

class CategoryFetcher: CategoryFetcherProtocol, RequestProtocol {
    private let session: URLSession
    private let urlString = "\(K.baseUrl)/api/categories"
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func getAll() async throws -> [ExpenseCategory] {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: "GET")
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200:
                guard let categories = try? JSONDecoder().decode([ExpenseCategory].self, from: data) else { throw NetworkError.invalidData }
                return categories
            default:
                throw NetworkError.unknown
            }
        }
        return []
    }
}
