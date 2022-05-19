//
//  ExpensesListView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 01/03/2022.
//

import SwiftUI

struct ExpensesListView: View {
    
    var expenses: [Expense]
    
    var body: some View {
        ZStack {
            if expenses.isEmpty {
                NoResultsView(forExpenses: true)
            } else {
                List {
                    ForEach(0..<expenses.count, id: \.self) { expenseIndex in
                        let expense = expenses[expenseIndex]
                        Button {
                            //TODO: - go to expense's details
                        } label: {
                            ExpenseCell(expense: expense)
                        }
                    }
                }
            }
        }
        .navigationBarItems(trailing:
                                NavigationLink {
            ExpenseFormView()
        } label: {
            Label("Add Item", systemImage: "plus")
        }
                                .simultaneousGesture(TapGesture().onEnded({ _ in
            
        }))            )
    }
}

struct ExpensesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListView(expenses: [])
    }
}
