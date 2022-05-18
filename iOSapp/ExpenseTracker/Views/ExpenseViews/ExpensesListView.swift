//
//  ExpensesListView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 01/03/2022.
//

import SwiftUI

struct ExpensesListView: View {
    
    @StateObject var expenseViewModel = ExpenseViewModel.sharedInstance
    
    var body: some View {
        List {
            ForEach(0..<expenseViewModel.expenses.count, id: \.self) { expenseIndex in
                let expense = expenseViewModel.expenses[expenseIndex]
                Button {
                    
                } label: {
                    ExpenseCell(expense: expense)
                }
            }
//            .onDelete(perform: expenseViewModel.deleteExpense)
        }
    }
}

struct ExpensesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListView()
    }
}
