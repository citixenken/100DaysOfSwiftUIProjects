//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Ken Muyesu on 18/05/2022.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    //keep data controller alive across entire app
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
