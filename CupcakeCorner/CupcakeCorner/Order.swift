//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ken Muyesu on 12/05/2022.
//

//MARK: - ViewModel

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Mint", "Strawberry", "Chocolate"]
    
    @Published var type = 3
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            extraFrosting = false
            addSprinkles = false
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
