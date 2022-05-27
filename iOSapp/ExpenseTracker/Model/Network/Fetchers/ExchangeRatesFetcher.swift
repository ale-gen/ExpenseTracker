//
//  ExchangeRatesFetcher.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 27/05/2022.
//

import Foundation

class ExchangeRatesFetcher: RequestProtocol {
    private let session: URLSession
    private let baseUrlString = "\(K.baseUrl)/api/exchangeRates"
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func getConverters(for currency: String) async throws -> ExchangeRates {
        let urlString = "\(baseUrlString)/for=\(currency)"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: "GET")
        let (data, _) = try await session.data(for: request)
        guard let exchangeRates = try? JSONDecoder().decode(ExchangeRates.self, from: data) else { throw NetworkError.invalidData }
        return exchangeRates
    }
}
