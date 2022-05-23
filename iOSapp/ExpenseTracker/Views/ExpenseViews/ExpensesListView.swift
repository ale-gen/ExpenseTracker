//
//  ExpensesListView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 01/03/2022.
//

import SwiftUI

struct ExpensesListView: View {
    
    var categoryId: Int
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    
    var body: some View {
        ZStack {
            if expenseViewModel.expenses.isEmpty {
                NoResultsView(forExpenses: true)
            } else {
                List {
                    ForEach(0..<expenseViewModel.expenses.count, id: \.self) { expenseIndex in
                        let expense = expenseViewModel.expenses[expenseIndex]
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
            ExpenseFormView(chosenCategoryId: categoryId)
        } label: {
            Label("Add Item", systemImage: "plus")
        }
                                .simultaneousGesture(TapGesture().onEnded({ _ in
            
        }))            )
        .onAppear {
            expenseViewModel.getExpenses(for: categoryId)
        }
    }
}

struct ExpensesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListView(categoryId: 1)
    }
}
