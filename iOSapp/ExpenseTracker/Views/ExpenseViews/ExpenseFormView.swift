//
//  ExpenseFormView.swift
//  ExpenseTracker
//
//  Created by Aleksandra Generowicz on 26/02/2022.
//

import SwiftUI
import Combine

struct ExpenseFormView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var expenseViewModel = ExpenseViewModel.sharedInstance
    @State var expenseName: String = ""
    @State var inputExpenseAmount: String = ""
    @State var selectedCurrency: Int = 0
    @State var isOptional: Bool = false
    @State var selectedDate: Date = Date.now
    @State var isDateChosen: Bool = true
    @State var chosenCategory: ExpenseCategory? = nil
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                TextField("Enter expense name...", text: $expenseName)
                NavigationLink(destination: CategoryListView(chosenCategory: $chosenCategory)) {
                    HStack {
                        Text("Category")
                        Spacer()
                        Text(chosenCategory?.name ?? "")
                    }
                }
            }
            Section(header: Text("Amount")) {
                Picker("", selection: $selectedCurrency) {
                    ForEach(0..<expenseViewModel.currencies.count, id: \.self) {
                        Text(expenseViewModel.currencies[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Enter expense amount...", text: $inputExpenseAmount)
                    .keyboardType(.decimalPad)
                    .onChange(of: inputExpenseAmount) { newValue in
                        expenseViewModel.validAmountInput(for: newValue)
                        inputExpenseAmount = expenseViewModel.inputExpenseAmount
                    }
                
            }
            Section(header: Text("Importance")) {
                Toggle(isOn: $isOptional) {
                    Text("Optional expense")
                }
            }
            Section(header: Text("Date")) {
                if isDateChosen {
                    HStack {
                        Text("Expense date")
                        Spacer()
                        Text(expenseViewModel.stringExpenseDate.capitalized)
                    }.onTapGesture {
                        withAnimation {
                            isDateChosen.toggle()
                        }
                    }
                } else {
                    DatePicker("Pick a date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .onChange(of: selectedDate) { newValue in
                            expenseViewModel.updateDate(for: newValue)
                            withAnimation {
                                isDateChosen.toggle()
                            }
                        }
                }
            }
        }
        .navigationBarTitle("New expense")
        .navigationBarItems(trailing:
                                Button {
            //            expenseViewModel.addExpense(name: expenseName, category: chosenCategory!, currency: expenseViewModel.currencies[selectedCurrency], unnecessary: isOptional)
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Save")
        }
                                .disabled(expenseName.isEmpty || chosenCategory == nil || inputExpenseAmount.isEmpty)
        )
    }
}

struct ExpenseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseFormView()
    }
}
