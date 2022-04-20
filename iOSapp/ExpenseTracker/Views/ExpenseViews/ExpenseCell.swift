//
//  ExpenseCell.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 14/03/2022.
//

import SwiftUI

struct ExpenseCell: View {
    var expense: Expense
    
    var body: some View {
        HStack {
            VStack {
                Text(expense.name)
                Text(expense.category.name)
            }
            Spacer()
            Text("\(expense.currency) \(String(format: "%.2f", expense.amount))")
        }
    }
}

//struct ExpenseCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseCell(expense: Expense())
//    }
//}
