//
//  NewCategoryView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 21/02/2022.
//

import SwiftUI

struct NewCategoryView: View {
    
//    let categoryViewModel: CategoryViewModel
    @StateObject var categoryViewModel = CategoryViewModel(fetcher: EmojiFetcher())
    
    var body: some View {
        VStack {
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
    }
}

struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView()
    }
}
