//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ken Muyesu on 05/05/2022.
//
//  MARK: - Our Model setup - Represents a single item of expense
import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
