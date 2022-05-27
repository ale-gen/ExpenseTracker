//
//  CurrencyConverter.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 27/05/2022.
//

import Foundation

struct CurrencyConverter {
    
    static func convert(amount: Double, fromCurrency: String, with rate: ExchangeRates) -> Double? {
        var convertedAmount = amount
        if let currency = ExchangeRate(rawValue: fromCurrency) {
            switch currency {
            case .pln:
                convertedAmount /= rate.converterPLN
            case .eur:
                convertedAmount /= rate.converterEUR
            case .usd:
                convertedAmount /= rate.converterUSD
            }
            return convertedAmount
        } else {
            print("There isn't an available currency to convert.")
        }
        return nil
    }
}
