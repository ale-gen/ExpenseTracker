//
//  Emoji.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 21/02/2022.
//

import Foundation

struct Emoji: Codable, Hashable {
    let name: String
    let unicode: [String]
}
