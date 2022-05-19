//
//  EmojiFetcher.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 21/02/2022.
//

import Foundation
import SwiftUI

protocol EmojiFetcherProtocol {
    func getAll() async throws -> [Emoji]
    func getByCategory(for categoryName: String) async throws -> [Emoji]
}

class EmojiFetcher: EmojiFetcherProtocol, RequestProtocol {
    private let session: URLSession
    private let baseUrlString = "https://emojihub.herokuapp.com/api/all"
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func getAll() async throws -> [Emoji] {
        guard let url = URL(string: baseUrlString) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: "GET")
        let (data, _) = try await session.data(for: request)
        guard let emojis = try? JSONDecoder().decode([Emoji].self, from: data) else { throw NetworkError.invalidData }
        return emojis
    }
    
    func getByCategory(for categoryName: String) async throws -> [Emoji] {
        let searchCategory = categoryName.replacingOccurrences(of: " ", with: "_")
        let urlString = "\(baseUrlString)/category_\(searchCategory)"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: "GET")
        let (data, _) = try await session.data(for: request)
        guard let emojis = try? JSONDecoder().decode([Emoji].self, from: data) else { throw NetworkError.invalidData }
        return emojis
    }
}
