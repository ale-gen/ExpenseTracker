//
//  GroupTabView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI
import CoreData

struct CategoriesTabView: View {
    
    @StateObject var categoryViewModel = CategoryViewModel(fetcher: EmojiFetcher())
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
                            TextField("Search", text: $searchText)
                                .padding(7)
                                .background(Color("ComponentsColor"))
                                .cornerRadius(10)
                            
                            ForEach(categoryViewModel.categories.filter{ searchText.isEmpty || $0.name.contains(searchText)
                            }, id: \.self) { category in
                                HStack {
                                    Text(category.icon ?? K.noCategoryIcon)
                                    Text(category.name)
                                }
                                .onTapGesture {
                                    categoryViewModel.updateCategory(for: category, name: "Food", icon: "🍏")
                                }
                            }
//                            .onDelete(of: categoryViewModel., perform: categoryViewModel.deleteCategory)
                        }
                    }
                }
                .navigationBarTitle(Text("Categories"))
                .navigationBarItems(trailing:
                                        NavigationLink {
                    NewCategoryView(categoryViewModel: categoryViewModel)
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
        CategoriesTabView(categoryViewModel: CategoryViewModel(fetcher: EmojiFetcher()))
    }
}
