//
//  ExpenseFormView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import SwiftUI

struct ExpenseFormView: View {
    
    @ObservedObject var inputExpenseAmount = NumbersOnly()
    
    var body: some View {
        TextField("Enter expense amount...", text: $inputExpenseAmount.value)
            .padding()
            .keyboardType(.decimalPad)
    }
}

struct ExpenseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseFormView()
    }
}
