//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ken Muyesu on 05/05/2022.
//
//  MARK: - Our Model setup - Represents a single item of expense
import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: Types
    let amount: Double
    
    enum Types: String, CaseIterable, Codable {
        case personal, business
    }
}
