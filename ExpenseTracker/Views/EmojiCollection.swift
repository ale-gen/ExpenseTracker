//
//  EmojiCollection.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 22/02/2022.
//

import SwiftUI

struct EmojiCollection: View {
    let emojis: [Emoji]
    
    let layout = [
        GridItem(.adaptive(minimum: 70))
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout, spacing: 10) {
                ForEach(emojis, id: \.self) { emoji in
                    EmojiCell(emoji: emoji)
                }
            }
        }
        .padding(.leading, 20)
    }
}

struct EmojiCollection_Previews: PreviewProvider {
    static var previews: some View {
        EmojiCollection(emojis: [Emoji(name: "Food", unicode: ["🍏"])])
    }
}
