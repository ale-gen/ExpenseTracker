//
//  Int+Extension.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/05/2022.
//

import Foundation

extension Int {
    
    func getDaysNumber(year: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: self)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let daysNumber = range.count
        return daysNumber
    }
}
