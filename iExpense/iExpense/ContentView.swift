//
//  ContentView.swift
//  iExpense
//
//  Created by Ken Muyesu on 05/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    //instance of expenses class
    @StateObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    VStack {
                        Text(item.name)
                            .foregroundColor(.primary)
                        Text(item.type)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    let expense = ExpenseItem(name: "tyres", type: "vehicular", amount: 20.00)
                    expenses.items.append(expense)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    //delete items from expenses array
    private func deleteItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
