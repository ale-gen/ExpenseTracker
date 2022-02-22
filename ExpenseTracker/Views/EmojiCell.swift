//
//  EmojiCell.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 22/02/2022.
//

import SwiftUI

struct EmojiCell: View {
    let emoji: Emoji
    let cellWidth = CGFloat(Int(UIScreen.main.bounds.width) / K.columnsNumber) - 20
    @Binding var isEmojiPicked: Bool
    @Binding var emojiPicked: Emoji?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: cellWidth, height: cellWidth)
                .foregroundColor(Color(K.customComponentColor))
            if let emojiUnicode = emoji.unicode.first {
                Button {
                    withAnimation {
                        isEmojiPicked.toggle()
                    }
                    emojiPicked = emoji
                } label: {
                    Text(EmojiFormatter.convertEmoji(for: emojiUnicode))
                }
            } else {
                Text(emoji.unicode.first ?? "")
            }
        }
    }
}

struct EmojiCell_Previews: PreviewProvider {
    static var previews: some View {
        EmojiCell(emoji: Emoji(name: "Food", unicode: ["🍏"]), isEmojiPicked: .constant(false), emojiPicked: .constant(Emoji(name: "Clothes shopping", unicode: ["🛍"])))
    }
}
