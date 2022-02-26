//
//  NumbersOnly.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import Foundation

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filteredData = value.filter { $0.isNumber }
            
            if value != filteredData {
                value = filteredData
            }
        }
    }
}
