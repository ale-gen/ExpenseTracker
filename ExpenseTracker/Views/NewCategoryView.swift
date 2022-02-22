//
//  NewCategoryView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 21/02/2022.
//

import SwiftUI

struct NewCategoryView: View {
    
    @StateObject var categoryViewModel = CategoryViewModel(fetcher: EmojiFetcher())
    @State var selectedCategory: String = ""
    @State var selectedIcon: String = ""
    
    var body: some View {
        VStack {
            Form {
                Picker("Icon category", selection: $selectedCategory) {
                    ForEach(K.iconCategories, id: \.self) { iconCategory in
                        Text(iconCategory)
                        .navigationTitle("Icon categories")
                    }
                }
                VStack(alignment: .leading) {
                    Text("Pick icon")
                    EmojiCollection(emojis: categoryViewModel.emojis)
                }
            }
        }
        .navigationBarTitle("New category")
    }
}

struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView()
    }
}
