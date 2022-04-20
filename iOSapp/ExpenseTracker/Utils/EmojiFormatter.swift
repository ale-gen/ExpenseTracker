//
//  EmojiFormatter.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 21/02/2022.
//

import Foundation

struct EmojiFormatter {
    static func convertEmoji(for unicode: String) -> String {
        let extractedUnicode = unicode.dropFirst(2)
        return String(UnicodeScalar(Int(extractedUnicode, radix: 16)!)!)
    }
}
