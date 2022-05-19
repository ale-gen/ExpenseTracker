//
//  NoResultsControl.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 19/05/2022.
//

import SwiftUI

struct NoResultsView: View {
    var forExpenses: Bool
    
    var body: some View {
        VStack {
            Image(K.noResultsImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text("No results")
                .font(.title2)
                .foregroundColor(Color(K.noResultsFontColor))
                .fontWeight(.bold)
            Text(forExpenses ? "Create new expense." : "Create own category.")
                .font(.subheadline)
                .foregroundColor(Color(K.noResultsFontColor))
        }
    }
}

struct NoResultsControl_Previews: PreviewProvider {
    static var previews: some View {
        NoResultsView(forExpenses: false)
    }
}
