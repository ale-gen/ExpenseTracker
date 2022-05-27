//
//  ExchangeRates.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 27/05/2022.
//

import Foundation

enum ExchangeRate: String {
    case pln = "PLN"
    case eur = "EUR"
    case usd = "USD"
}

struct ExchangeRates: Decodable {
    let converterEUR: Double
    let converterUSD: Double
    let converterPLN: Double
}
