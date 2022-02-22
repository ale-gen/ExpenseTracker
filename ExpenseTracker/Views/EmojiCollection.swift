//
//  EmojiCollection.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 22/02/2022.
//

import SwiftUI

struct EmojiCollection: View {
    let emojis: [Emoji]
    
    let layout: [GridItem] = Array(repeating: .init(.fixed(40)), count: 3)
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout, alignment: .top, spacing: 10) {
                    ForEach(emojis, id: \.self) { emoji in
                        EmojiCell(emoji: emoji)
                    }
            }
        }
        .frame(maxHeight: 150)
    }
}

struct EmojiCollection_Previews: PreviewProvider {
    static var previews: some View {
        EmojiCollection(emojis: [Emoji(name: "Food", unicode: ["🍏"])])
    }
}
