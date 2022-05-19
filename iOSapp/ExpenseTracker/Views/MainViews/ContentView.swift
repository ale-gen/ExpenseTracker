//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var categoryViewModel = CategoryViewModel(categoryFetcher: CategoryFetcher(), emojiFetcher: EmojiFetcher())
    
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
                .environmentObject(categoryViewModel)
            
            SettingsTabView()
                .tabItem {
                    VStack {
                        Text(K.settingsTabName)
                        Image(systemName: K.settingsTabIcon)
                    }
                }
        }
        .onAppear {
            categoryViewModel.getCategories()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
