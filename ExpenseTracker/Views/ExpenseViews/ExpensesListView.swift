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
            ForEach(expenseViewModel.expenses, id: \.self) { expense in
                Button {
                    
                } label: {
                    HStack {
                        Text(expense.name)
                        Text("\(expense.amount)")
                        Text(expense.currency)
                    }
                }
            }
        }
    }
}

struct ExpensesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListView()
    }
}
