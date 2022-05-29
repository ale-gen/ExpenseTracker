//
//  SettingsTabView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI

struct SettingsTabView: View {
    
    var expenseModel: ExpenseModel = .init()
    @AppStorage("PreferredCurrency") var currencyPreferenceSelection = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Picker("Currency", selection: $currencyPreferenceSelection) {
                        ForEach(expenseModel.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
}

struct SettingsTabView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView()
    }
}
