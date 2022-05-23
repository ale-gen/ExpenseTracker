//
//  GroupTabView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI

struct CategoriesTabView: View {
    
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    @StateObject var expenseViewModel = ExpenseViewModel(expenseModel: ExpenseModel(), expenseFetcher: ExpenseFetcher())
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    if (categoryViewModel.categories.count == 0) {
                        NoResultsView(forExpenses: false)
                    } else {
                        List {
                            ForEach(categoryViewModel.categories.filter({ category in
                                searchText.isEmpty || category.name.contains(searchText)
                            }), id: \.self) { category in
                                NavigationLink {
                                    ExpensesListView(categoryId: category.id, expenses: category.expenses)
                                        .navigationTitle(category.name)
                                } label: {
                                    HStack {
                                        Text(category.icon ?? K.noCategoryIcon)
                                        Text(category.name)
                                        Spacer()
                                        if let expensesForCategory = category.expenses.count {
                                            Text("\(expensesForCategory)")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: delete)
                        }
                        .padding(10)
                        .menuIndicator(.visible)
                    }
                }
                .searchable(text: $searchText)
                .navigationBarTitle(Text("Categories"))
                .navigationBarItems(trailing:
                                        NavigationLink {
                    NewCategoryView()
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
                                        .simultaneousGesture(TapGesture().onEnded({ _ in
                    categoryViewModel.getAllEmojis()
                }))            )}
        }
        .onAppear {
            categoryViewModel.getCategories()
        }
        .environmentObject(expenseViewModel)
    }
    
    func delete(at offsets: IndexSet) {
        categoryViewModel.deleteCategory(indexSet: offsets)
    }
}

struct GroupTabView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesTabView()
    }
}
