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
    
    var body: some View {
        VStack {
            Form {
                Picker("Icon category", selection: $selectedCategory) {
                    ForEach(K.iconCategories, id: \.self) { iconCategory in
                        Text(iconCategory)
                        .navigationTitle("Icon categories")
                    }
                }
            }
            
            Button {
                categoryViewModel.getAllEmojis()
            } label: {
                Text("Load emoji")
            }
            
            List {
                ForEach(categoryViewModel.emojis, id: \.self) {
                    emoji in
                    HStack {
                        Text(emoji.name)
                        if let emoji = emoji.unicode.first {
                            Text(EmojiFormatter.convertEmoji(for: emoji))
                        } else {
                            Text(emoji.unicode.first ?? "")
                        }
                    }
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
