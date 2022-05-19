//
//  Constants.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import Foundation
import SwiftUI

struct K {
    static let baseUrl = "http://localhost:8080"
    static let noCategoryIcon = "❓"
    static let noCategoryIconUnicode = "U+2753"
    static let noResultsImageName = "emptyData"
    static let containerName = "ExpenseTracker"
    
    static let iconCategories = ["smileys and people", "animals and nature", "food and drink", "travel and places", "activities", "objects", "symbols", "flags"]
    
    //MARK: - Tab names
    static let homeTabName = "Home"
    static let categoriesTabName = "Categories"
    static let settingsTabName = "Settings"
    
    //MARK: - Tab icon
    static let homeTabIcon = "house.fill"
    static let categoriesTabIcon = "list.bullet"
    static let settingsTabIcon = "slider.vertical.3"
    
    //MARK: - Collection Cell features
    static let columnsNumber = 6
    static let rowsNumber = 4
    
    //MARK: - Colors
    static let borderColor = Color(red: 120/255, green: 122/255, blue: 145/255, opacity: 1)
    static let customNavyColor = Color(red: 20/255, green: 39/255, blue: 155/255, opacity: 1)
    static let customOrangeColor = Color(red: 1, green: 130/255, blue: 67/255, opacity: 1)
    static let noResultsFontColor = "CustomFontColor"
    static let customComponentColor = "ComponentsColor"
}
