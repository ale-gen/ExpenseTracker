//
//  HomeTabView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        NavigationView {
            ExpensesListView()
                .navigationBarTitle(Text("Expenses"))
                .navigationBarItems(trailing:
                                        NavigationLink {
                    ExpenseFormView()
                } label: {
                    Label("Add Item", systemImage: "plus")
                })
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
