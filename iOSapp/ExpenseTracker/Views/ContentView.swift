//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        TabView {
            HomeTabView()
                .tabItem {
                    VStack {
                        Text(K.homeTabName)
                        Image(systemName: K.homeTabIcon)
                    }
                }
            
            CategoriesTabView()
                .tabItem {
                    VStack {
                        Text(K.categoriesTabName)
                        Image(systemName: K.categoriesTabIcon)
                    }
                }
            
            SettingsTabView()
                .tabItem {
                    VStack {
                        Text(K.settingsTabName)
                        Image(systemName: K.settingsTabIcon)
                    }
                }
        }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
