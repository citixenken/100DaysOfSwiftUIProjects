//
//  Expenses.swift
//  iExpense
//
//  Created by Ken Muyesu on 05/05/2022.
//

//  MARK: - ViewModel - Class that stores an array of all items

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                //save - encoding
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    //read data from UserDefaults - Decoding
    init() {
        let decoder = JSONDecoder()
        
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? decoder.decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        //else
        items = []
    }
    
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == .personal }
    }
    
    var businessItems: [ExpenseItem] {
        items.filter { $0.type == .business }
    }

}
