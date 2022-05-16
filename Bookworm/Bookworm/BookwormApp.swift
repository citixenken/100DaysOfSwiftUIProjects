//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Ken Muyesu on 14/05/2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    //keep our data controller alive across entire app
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
