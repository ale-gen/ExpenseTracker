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
    
    static func getMonth(for date: Date) -> Int {
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: date)
        return Int(month) ?? 0
    }
    
    static func getYear(for date: Date) -> String {
        dateFormatter.dateFormat = "yy"
        let year = dateFormatter.string(from: date)
        return year
    }
    
    static func getLongYear(for date: Date) -> String {
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        return year
    }
    
    static func getCurrentDate() -> String {
        let day = getDay(for: Date.now)
        let month = getMonthName(for: Date.now)
        
        return "\(day), \(month)"
    }
    
    static func formatDate(for date: Date) -> String {
        let day = DateConverter.getDay(for: date)
        let monthName = DateConverter.getMonthName(for: date)
        let expenseYear = DateConverter.getYear(for: date)
        let currentYear = DateConverter.getYear(for: Date.now)
        var convertedDate: String
        
        if expenseYear == currentYear {
            convertedDate = "\(day), \(monthName)"
        } else {
            convertedDate = "\(day), \(monthName) \(expenseYear)"
        }
        return convertedDate
    }
    
    static func formatDateFromString(for stringDate: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: stringDate) ?? Date.now
        return formatDate(for: date)
    }
    
    static func extractDate(stringDate: String) -> (Int, Int, Int)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: stringDate)
        if let safeDate = date {
            let day = Calendar.current.component(.day, from: safeDate)
            let month = Calendar.current.component(.month, from: safeDate)
            let year = Calendar.current.component(.year, from: safeDate)
            return (day, month, year)
        }
        return nil
    }
}
