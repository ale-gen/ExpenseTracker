//
//  ExpenseFormView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import SwiftUI
import Combine

struct ExpenseFormView: View {
    
    @StateObject var expenseViewModel = ExpenseViewModel(expenseModel: ExpenseModel())
    @State var expenseName: String = ""
    @State var inputExpenseAmount: String = ""
    @State var selectedCurrency: Int = 0
    
    var body: some View {
        Form {
            TextField("Enter expense name...", text: $expenseName)
            Picker("", selection: $selectedCurrency) {
                ForEach(0..<expenseViewModel.currencies.count, id: \.self) {
                    Text(expenseViewModel.currencies[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            TextField("Enter expense amount...", text: $inputExpenseAmount)
                .keyboardType(.decimalPad)
                .onChange(of: inputExpenseAmount) { newValue in
                    expenseViewModel.validAmountInput(for: newValue)
                    inputExpenseAmount = expenseViewModel.inputExpenseAmount
                }
        }
        .navigationBarTitle("New expense")
    }
}

struct ExpenseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseFormView()
    }
}
