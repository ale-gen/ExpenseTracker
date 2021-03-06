//
//  NewCategoryView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 21/02/2022.
//

import SwiftUI

struct NewCategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    @State var categoryName: String = ""
    @State var isEmojiPicked: Bool = false
    @State var emojiPicked: Emoji? = nil
    
    var body: some View {
        VStack {
            Form {
                TextField("Expense category name", text: $categoryName) {

                }
                Picker("Icon category", selection: $categoryViewModel.chosenCategory) {
                    ForEach(K.iconCategories, id: \.self) { iconCategory in
                        Text(iconCategory.capitalized)
                    }
                    .navigationTitle("Icon categories")
                }
                if !isEmojiPicked {
                    VStack(alignment: .leading) {
                        Text("Pick icon")
                            .padding(.top, 10)
                        EmojiCollection(emojis: categoryViewModel.emojis, emojiPicked: $emojiPicked, isEmojiPicked: $isEmojiPicked)
                            .overlay(loadingView)
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
                                EmojiCell(emoji: safeEmoji)
                            }
                        }
                    }
                }
                
            }
            Button {
                if !categoryName.isEmpty {
                    let emojiUnicode = EmojiFormatter.convertEmoji(for: emojiPicked?.unicode.first ?? K.noCategoryIconUnicode)
                    categoryViewModel.addCategory(name: categoryName, userIcon: emojiUnicode)
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Add")
                    .foregroundColor(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(K.customNavyColor)
                    .cornerRadius(10)
                    .padding(10)
            }
            .disabled(categoryName.isEmpty)
            .buttonStyle(PlainButtonStyle())
        }
        .onChange(of: categoryViewModel.chosenCategory, perform: { _ in
            categoryViewModel.getEmojisForChosenCategory()
        })
        .navigationBarTitle("New category")
    }
    
    
    @ViewBuilder
    private var loadingView: some View {
        if (categoryViewModel.isLoading) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding(20)
                .background(.regularMaterial)
                .mask(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView()
    }
}
