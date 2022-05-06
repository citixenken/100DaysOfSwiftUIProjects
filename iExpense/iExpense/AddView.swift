//
//  AddView.swift
//  iExpense
//
//  Created by Ken Muyesu on 05/05/2022.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = ExpenseItem.Types.business
    @State private var amount = 0.0
    
    //let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Expense", text: $name)
                        .autocapitalization(UITextAutocapitalizationType.sentences)
                } header: {
                    Text("Name")
                }
                
                Section {
                    Picker("Type", selection: $type) {
                        ForEach(ExpenseItem.Types.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Type")
                }
                
                Section {
                    TextField("Amount", value: $amount, format: .currency(code: "kes"))
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Amount")
                }
            }
            .navigationTitle("Add New Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let expense = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(expense)
                    
                    //after saving
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
