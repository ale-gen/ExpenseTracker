//
//  Constants.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import Foundation
import SwiftUI

struct K {
    static let noCategoryIcon = "❓"
    static let noCategoriesImageName = "emptyData"
    static let containerName = "ExpenseTracker"
    
    static let iconCategories = ["Smileys and people", "Animals and nature", "Food and drink", "Travel and places", "Activities", "Objects", "Symbols", "Flags"]
    
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
