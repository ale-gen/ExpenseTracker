//
//  CategoryListView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 01/03/2022.
//

import SwiftUI

struct CategoryListView: View {
    
    @Environment(\.presentationMode) var presenationMode
    @StateObject var categoryViewModel = CategoryViewModel(fetcher: EmojiFetcher())
    @Binding var chosenCategory: ExpenseCategory?
    
    var body: some View {
        List {
            ForEach(categoryViewModel.categories, id: \.self) { category in
                Button {
                    withAnimation {
                        chosenCategory = category
                    }
                    presenationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text(category.icon ?? K.noCategoryIcon)
                        Text(category.name)
                        Spacer()
                        if let safeChosenCategory = chosenCategory {
                            if let chosenCategoryName = safeChosenCategory.name {
                                if category.name == chosenCategoryName {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.blue)
                                }
                            }
                        }
                    }
                }.foregroundColor(.primary)
            }
        }
    }
}
