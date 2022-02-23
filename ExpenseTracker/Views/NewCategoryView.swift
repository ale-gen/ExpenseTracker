//
//  NewCategoryView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 21/02/2022.
//

import SwiftUI

struct NewCategoryView: View {
    
    @StateObject var categoryViewModel = CategoryViewModel(fetcher: EmojiFetcher())
    @State var categoryName: String = ""
    @State var selectedCategory: String = ""
    @State var isEmojiPicked: Bool = false
    @State var emojiPicked: Emoji? = nil
    
    var body: some View {
        VStack {
            Form {
                TextField("Expense category name", text: $categoryName) {

                }
                Picker("Icon category", selection: $selectedCategory) {
                    ForEach(K.iconCategories, id: \.self) { iconCategory in
                        Text(iconCategory)
                        .navigationTitle("Icon categories")
                    }
                }
                if !isEmojiPicked {
                    VStack(alignment: .leading) {
                        Text("Pick icon")
                            .padding(.top, 10)
                        EmojiCollection(emojis: categoryViewModel.emojis, emojiPicked: $emojiPicked, isEmojiPicked: $isEmojiPicked)
                    }
                } else {
                    Button {
                        withAnimation {
                            isEmojiPicked.toggle()
                        }
                    } label: {
                        HStack {
                            Text("Expense category icon")
                                .foregroundColor(.primary)
                            Spacer()
                            if let safeEmoji = emojiPicked {
                                EmojiCell(emoji: safeEmoji, isEmojiPicked: $isEmojiPicked, emojiPicked: $emojiPicked)
                            }
                        }
                    }
                }
                
            }
            Button {
                
            } label: {
                Text("Add")
                    .foregroundColor(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(K.customNavyColor)
                    .cornerRadius(10)
                    .padding(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .navigationBarTitle("New category")
    }
}

struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView()
    }
}
