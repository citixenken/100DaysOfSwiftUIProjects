//
//  ExpenseSectionView.swift
//  iExpense
//
//  Created by Ken Muyesu on 06/05/2022.
//

import SwiftUI

struct ExpenseSectionView: View {
    let heading: ExpenseItem.Types
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section {
            ForEach(expenses) { item in
                HStack {
                    VStack (alignment: .leading){
                        Text(item.name)
                            .font(.headline)
                            .foregroundColor(.primary)
//                        Text(item.type)
//                            .foregroundColor(.secondary)
                    }
                    Spacer()

                    Text(item.amount, format: .currency(code: "kes"))
                        //.displayStyle(for: item)
                        .foregroundColor(item.amount <= 99 ? Color.blue : item.amount <= 999 ? Color.green : Color.orange)
                }
            }
            .onDelete(perform: deleteItems)
        } header: {
            HStack {
                Text(heading.rawValue.capitalized)
                Spacer()
                Text(totalAmount(for: expenses), format: .currency(code: "kes"))
            }
        }
    }
    
    func totalAmount(for expenseItem: [ExpenseItem]) -> Double {
        expenseItem.map { $0.amount }.reduce( 0, + )
    }
}

struct ExpenseSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseSectionView(heading: .business, expenses: []) { _ in }
    }
}
