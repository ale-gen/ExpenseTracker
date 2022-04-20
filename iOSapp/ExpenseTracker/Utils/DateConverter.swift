//
//  DateFormatter.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 01/03/2022.
//

import Foundation

struct DateConverter {
    
    private static let dateFormatter = DateFormatter()
    
    static func getDay(for date: Date) -> String {
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)
        return day
    }
    
    static func getMonthName(for date: Date) -> String {
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: date)
        return month
    }
    
    static func getYear(for date: Date) -> String {
        dateFormatter.dateFormat = "yy"
        let year = dateFormatter.string(from: date)
        return year
    }
    
    static func getCurrentDate() -> String {
        let day = getDay(for: Date.now)
        let month = getMonthName(for: Date.now)
        
        return "\(day), \(month)"
    }
}
