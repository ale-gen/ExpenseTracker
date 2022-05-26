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
                    ForEach(Array(expenseViewModel.expensesByDate.keys.sorted().reversed()), id: \.self) { expenseDate in
                        if let expenses = expenseViewModel.expensesByDate[expenseDate] {
                            Section(header: Text(DateConverter.formatDateFromString(for: expenseDate))) {
                                ForEach(0..<expenses.count, id: \.self) { expenseIndex in
                                    let expense = expenses[expenseIndex]
                                    ExpenseCell(expense: expense)
                                }
                                .onDelete { indexSet in
                                    for index in indexSet {
                                        expenseViewModel.deleteExpense(for: categoryId, expenseId: expenses[index].id)
                                    }
                                }
                            }
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
