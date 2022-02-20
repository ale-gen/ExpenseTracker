//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
