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
    
    //delivery details
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    //computed property
    var hasValidDeliveryAddress: Bool {
        if (name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty) {
            return false
        }
        
        return true
    }
    
    //costing params
    var cost: Double {
        //std price -> Ksh. 2 per cake
        var cost = Double(quantity) * 2
        
        //complicated cakes cost more -> arranged in order of complexity @types
        cost += (Double(type) / 2)
        
        //Ksh. 1 per cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //Ksh. 0.50 per cake for sprinkles
        if addSprinkles {
            cost += (Double(quantity) / 2)
        }
        
        return cost
    }
}
