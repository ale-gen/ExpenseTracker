//
//  NetworkError.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 06/05/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case unknown
}
