//
//  Mission.swift
//  Moonshot
//
//  Created by Ken Muyesu on 06/05/2022.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct Crew: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let crew: [Crew]
    let description: String
    let launchDate: String?
}



