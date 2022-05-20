//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Ken Muyesu on 19/05/2022.
//
//

import Foundation
import CoreData
import SwiftUI


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var aliasName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var firstName: String?
    
    var wrappedAliasName: String {
        aliasName ?? "Unknown"
    }
    
    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
    
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }
    

}

extension Singer : Identifiable {

}
