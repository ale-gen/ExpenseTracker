//
//  GroupTabView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI
import CoreData

struct CategoriesTabView: View {
    
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    if (categoryViewModel.categories.count == 0) {
                        VStack {
                            Image(K.noCategoriesImageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            Text("No results")
                                .font(.title2)
                                .foregroundColor(Color(K.noResultsFontColor))
                                .fontWeight(.bold)
                            Text("Create own category.")
                                .font(.subheadline)
                                .foregroundColor(Color(K.noResultsFontColor))
                        }
                        
                    } else {
                        List {
                            ForEach(categoryViewModel.categories.filter({ category in
                                searchText.isEmpty || category.name.contains(searchText)
                            }), id: \.self) { category in
                                HStack {
                                    Text(category.icon ?? K.noCategoryIcon)
                                    Text(category.name)
                                    Spacer()
                                    if let expensesForCategory = category.expenses.count {
                                        Text("\(expensesForCategory)")
                                            .foregroundColor(.gray)
                                        Image(systemName: "chevron.forward")
                                            .padding(.trailing, 10)
                                            .foregroundColor(.gray)
                                    }
                                }
//                                .onTapGesture {
//                                    categoryViewModel.updateCategory(for: category, name: "Food", icon: "🍏")
//                                }
                            }
//                            .onDelete(perform: categoryViewModel.deleteCategory)
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
    }
}

struct GroupTabView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesTabView()
    }
}
