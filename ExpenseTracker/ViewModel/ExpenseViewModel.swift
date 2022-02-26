//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    
    @Published var inputExpenseAmount: String = ""
    
    func validAmountInput(for input: String) {
        inputExpenseAmount = NumbersOnly.filterNumbers(for: input)
    }
    
}
