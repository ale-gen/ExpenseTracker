//
//  Emoji.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 21/02/2022.
//

import Foundation

struct EmojiList: Codable {
    let emojis: [Emoji]
}

struct Emoji: Codable, Hashable {
    let name: String
    let unicode: [String]
}
