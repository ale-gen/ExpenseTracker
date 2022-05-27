//
//  HomeTabView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI

struct HomeTabView: View {
    
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel(categoryFetcher: CategoryFetcher(), exchangeRatesFetcher: ExchangeRatesFetcher())
    @State var chosenMonthSummary: String = "May"
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<homeViewModel.availableChoices.count, id: \.self) { choiceIndex in
                            let choice = homeViewModel.availableChoices[choiceIndex]
                            Button {
                                withAnimation {
                                    chosenMonthSummary = choice
                                }
                            } label: {
                                Text(choice)
                                    .fontWeight(.light)
                                    .font(.subheadline)
                                    .foregroundColor(Color.primary)
                                    .frame(minWidth: 40)
                                    .padding(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("CustomFontColor"), lineWidth: 0.5)
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(choice == chosenMonthSummary ? Color.accentColor : Color(UIColor.systemBackground))
                                    )
                            }
                        }
                    }
                }
                .padding([.top, .bottom], 10)
                
                let data = homeViewModel.dailyExpenses[chosenMonthSummary]
                if data?.count ?? 0 > 0 {
                    ChartView(data: data ?? [])
                }
                Spacer()
            }
            .onAppear {
                homeViewModel.fetchCategories()
            }
            .navigationBarTitle(Text("Monthly summary"))
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
