//
//  Expenses.swift
//  iExpense
//
//  Created by Ken Muyesu on 05/05/2022.
//

//  MARK: - ViewModel - Class that stores an array of all items

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
