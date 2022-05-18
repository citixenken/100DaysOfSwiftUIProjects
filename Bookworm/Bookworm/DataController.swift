//
//  DataController.swift
//  Bookworm
//
//  Created by Ken Muyesu on 16/05/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    //use our CoreDataProject datamodel
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
