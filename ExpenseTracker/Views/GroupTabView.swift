//
//  GroupTabView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI
import CoreData

struct GroupTabView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //var categories: [ExpenseCategory] = [ExpenseCategory(name: "Food", icon: "🍏"), ExpenseCategory(name: "Clothes shopping", icon: "🛍")]
    @FetchRequest(entity: ExpenseCategory.entity(), sortDescriptors: [])
    var categories: FetchedResults<ExpenseCategory>
    
    var body: some View {
        ZStack {
            NavigationView {
                if (categories.count == 0) {
                    VStack {
                        Image("emptyData")
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
                        Section(header: Text("My categories")) {
                            ForEach(categories, id: \.self) { category in
                                HStack {
                                    Text(category.icon ?? K.noCategoryIcon)
                                    Text(category.name)
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        //action from viewModel
                    } label: {
                        Label("Add Item", systemImage: "plus")
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
