//
//  TabBarView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 18/02/2022.
//

import SwiftUI

struct TabsView: View {
    @State var selectedTabBar = 0
    @State var presented = false
    let tabItemLabels = K.tabItemLabels
    let tabItemImages = K.tabItemImages
    
    var body: some View {
        VStack {
            ZStack {
                Spacer().sheet(isPresented: $presented) {
                    NavigationView {
                        Text("ModalScreen")
                            .navigationBarItems(leading:
                                                    Button(action: {
                                self.presented.toggle()
                            }, label: {
                                Text("Cancel")
                            }), trailing:
                                                    Button(action: {
                                self.presented.toggle()
                            }, label: {
                                Text("Save")
                            }))
                    }
                }
                
                switch selectedTabBar {
                case 0:
                    NavigationView {
                        Text("Trip tab item")
                    }
                case 1:
                    NavigationView {
                        Text("Charts tab item")
                    }
                case 2:
                    NavigationView {
                        Text("Plus")
                    }
                case 3:
                    NavigationView {
                        Text("Categories")
                    }
                default:
                    NavigationView {
                        Text("Search tab item")
                    }
                }
            }
            Spacer()
            HStack {
                ForEach(0..<tabItemImages.count, id: \.self) { number in
                    Spacer()
                    Button {
                        if (number == 2) {
                            presented.toggle()
                        } else {
                            self.selectedTabBar = number
                        }
                    } label: {
                        VStack {
                            if (number == 2) {
                                Image(systemName: tabItemImages[number])
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                                    .background(K.customNavyColor)
                                    .cornerRadius(30)
                            } else {
                                Image(systemName: tabItemImages[number])
                                    .font(.system(size: 20))
                                Text(tabItemLabels[number])
                                    .font(.system(size: 12))
                                    .padding([.top], 5)
                            }
                        }
                        .foregroundColor(selectedTabBar == number ? .blue : .gray)
                        
                    }
                    Spacer()
                }
            }
        }
        .padding(.bottom, 5)
    }
}

struct CategoriesTabView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 8")
    }
}
