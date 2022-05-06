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
                
                if expenses.businessItems.isNotEmpty {
                    ExpenseSectionView(heading: .business, expenses: expenses.businessItems, deleteItems: removeBusinessItems)
                }
                if expenses.personalItems.isNotEmpty {
                    ExpenseSectionView(heading: .personal, expenses: expenses.personalItems, deleteItems: removePersonalItems)

                }
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
//    private func deleteItem(at offsets: IndexSet) {
//        expenses.items.remove(atOffsets: offsets)
//    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectToDelete = IndexSet()
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectToDelete.insert(index)
            }
        }
        expenses.items.remove(atOffsets: objectToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }

}

//custom amount display modifier
struct DisplayModifier: ViewModifier {
    let item: ExpenseItem
    
    func body(content: Content) -> some View {
        switch item.amount {
        case 0...99:
            content
                .foregroundColor(.secondary)
        case 100...999:
            content
                .foregroundColor(.green)
        default:
            content
                .foregroundColor(.red)
        }
        
    }
}

extension View {
    func displayStyle(for item: ExpenseItem) -> some View {
        modifier(DisplayModifier(item: item))
    }
}

extension Collection {
    var isNotEmpty: Bool {
        self.isEmpty == false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
