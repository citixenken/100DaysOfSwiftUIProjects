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
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack (alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(item.type)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "kes"))
                            .foregroundColor(.red)
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    showingAddView = true
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddView(expenses: expenses)
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
