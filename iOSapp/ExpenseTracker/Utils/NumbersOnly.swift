//
//  NumbersOnly.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import Foundation

struct NumbersOnly {
    static func filterNumbers(for input: String) -> String {
        let availablePunctuation = [Character("."), Character(",")]
        var result: String
        let filteredData = input.filter { $0.isNumber || availablePunctuation.contains($0) }
        let reducedData = filteredData.reduce("") { partialResult, char in
            if !char.isNumber && !(partialResult.contains(availablePunctuation[0]) || partialResult.contains(availablePunctuation[1])) {
                return "\(partialResult)\(char)"
            } else if char.isNumber {
                return "\(partialResult)\(char)"
            } else {
                return partialResult
            }
        }
        //TODO: - Fix decimal format - 2 digit after commas or dot
        if input != reducedData {
            result = reducedData
        } else {
            result = input
        }
        return result
    }
}
