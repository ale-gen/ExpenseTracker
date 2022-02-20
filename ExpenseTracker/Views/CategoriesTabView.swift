//
//  GroupTabView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI
import CoreData

struct CategoriesTabView: View {
    
    @StateObject var categoryViewModel = CategoryViewModel()
    
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
                                .foregroundColor(K.customNavyColor)
                                .fontWeight(.bold)
                            Text("Create own category.")
                                .font(.subheadline)
                                .foregroundColor(K.customNavyColor)
                        }
                        
                    } else {
                        List {
                            ForEach(categoryViewModel.categories, id: \.self) { category in
                                HStack {
                                    Text(category.icon ?? K.noCategoryIcon)
                                    Text(category.name)
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Categories"))
                .navigationBarItems(trailing:
                                        Button {
                    categoryViewModel.addCategory(name: "Clothes shopping", icon: "🛍")
                } label: {
                    Label("Add Item", systemImage: "plus")
                    
                })
            }
        }
    }
}

struct GroupTabView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesTabView(categoryViewModel: CategoryViewModel())
    }
}
