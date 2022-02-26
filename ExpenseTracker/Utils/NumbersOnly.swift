//
//  NumbersOnly.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import Foundation

struct NumbersOnly {
    static func filterNumbers(for input: String) -> String {
        var result: String
        let filteredData = input.filter { $0.isNumber }
        
        if input != filteredData {
            result = filteredData
        } else {
            result = input
        }
        return result
    }
}
