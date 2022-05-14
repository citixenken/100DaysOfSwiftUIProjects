//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ken Muyesu on 12/05/2022.
//

//MARK: - ViewModel

import SwiftUI

class Order: ObservableObject, Codable {
    
    //@Published properties
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
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
//        if (name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty) {
//            return false
//        }
        if (name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
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
    //empty init with NO params
    init() {}
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        //type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)

    }
}
