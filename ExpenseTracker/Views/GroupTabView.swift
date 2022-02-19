//
//  GroupTabView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI

struct ExpenseCategory: Hashable {
    let name: String
    let icon: String
}

struct GroupTabView: View {
    var categories: [ExpenseCategory] = [ExpenseCategory(name: "Food", icon: "🍏"), ExpenseCategory(name: "Clothes shopping", icon: "🛍")]
    var body: some View {
        List {
            Section(header: Text("My categories")) {
                ForEach(categories, id: \.self) { category in
                    HStack {
                        Text(category.icon)
                        Text(category.name)
                    }
                }
            }
        }
    }
}

struct GroupTabView_Previews: PreviewProvider {
    static var previews: some View {
        GroupTabView()
    }
}
