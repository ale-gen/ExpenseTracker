//
//  Constants.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import Foundation
import SwiftUI

struct K {
    static let tabItemLabels = ["Trips", "Charts", "", "Groups", "Search"]
    static let tabItemImages = ["case.fill", "chart.bar.xaxis", "plus", "list.bullet", "magnifyingglass"]
    static let monthsTable = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Nov", "Dec"]
    
    //MARK: - Tab names
    static let homeTabName = "Home"
    static let groupTabName = "Group"
    static let settingsTabName = "Settings"
    
    //MARK: - Tab icon
    static let homeTabIcon = "home.fill"
    static let groupTabIcon = "list.bullet"
    static let settingsTabIcon = "slider.vertical.3"
    
    //MARK: - Colors
    static let borderColor = Color(red: 120/255, green: 122/255, blue: 145/255, opacity: 1)
    static let customNavyColor = Color(red: 20/255, green: 39/255, blue: 155/255, opacity: 1)
    static let customOrangeColor = Color(red: 1, green: 130/255, blue: 67/255, opacity: 1)
}
