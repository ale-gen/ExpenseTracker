//
//  ExpenseFormView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import SwiftUI
import Combine

struct ExpenseFormView: View {
    
    @StateObject var expenseViewModel = ExpenseViewModel()
    @State var inputExpenseAmount: String = ""
    
    var body: some View {
        TextField("Enter expense amount...", text: $inputExpenseAmount)
            .padding()
            .keyboardType(.decimalPad)
            .onChange(of: inputExpenseAmount) { newValue in
                expenseViewModel.validAmountInput(for: newValue)
                inputExpenseAmount = expenseViewModel.inputExpenseAmount
            }
    }
}

struct ExpenseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseFormView()
    }
}
