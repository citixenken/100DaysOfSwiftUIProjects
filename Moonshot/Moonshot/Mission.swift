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
    let launchDate: Date?
    
    //computed properties
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .long, time: .omitted) ?? "Did not launch"
    }
}



