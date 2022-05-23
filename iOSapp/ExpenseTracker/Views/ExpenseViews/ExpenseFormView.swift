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
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    @State var isDateChosen: Bool = true
    var chosenCategoryId: Int
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                TextField("Enter expense name...", text: $expenseViewModel.expenseName)
            }
            Section(header: Text("Amount")) {
                Picker("", selection: $expenseViewModel.selectedCurrency) {
                    ForEach(0..<expenseViewModel.currencies.count, id: \.self) {
                        Text(expenseViewModel.currencies[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Enter expense amount...", text: $expenseViewModel.expenseAmount)
                    .keyboardType(.decimalPad)
                    .onChange(of: expenseViewModel.expenseAmount) { newValue in
                        expenseViewModel.validAmountInput(for: newValue)
                    }
                
            }
            Section(header: Text("Importance")) {
                Toggle(isOn: $expenseViewModel.isOptional) {
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
                    DatePicker("Pick a date", selection: $expenseViewModel.selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .onChange(of: expenseViewModel.selectedDate) { newValue in
                            expenseViewModel.updateDate(for: newValue)
                            withAnimation {
                                isDateChosen.toggle()
                            }
                        }
                }
            }
        }
        .alert(isPresented: $expenseViewModel.isErrorAppeared) {
            Alert(title: Text(expenseViewModel.errorAlertTitle),
                  message: Text(expenseViewModel.errorMessage), dismissButton: .cancel(Text("OK")))
        }
        .navigationBarTitle("New expense")
        .navigationBarItems(trailing:
                                Button {
            expenseViewModel.addExpense(for: chosenCategoryId)
            if !expenseViewModel.isErrorAppeared {
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Text("Save")
        }
                                .disabled(expenseViewModel.expenseName.isEmpty || expenseViewModel.expenseAmount.isEmpty)
        )
    }
}

struct ExpenseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseFormView(chosenCategoryId: 1)
    }
}
