//
//  DataController.swift
//  CoreDataProject
//
//  Created by Ken Muyesu on 18/05/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    //using our CoreDataProject datamodel
    
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
