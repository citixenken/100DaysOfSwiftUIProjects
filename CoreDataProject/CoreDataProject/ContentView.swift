//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Ken Muyesu on 18/05/2022.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: nil) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown ship")
            }
            
            Button("Add Vessel") {
                let shipOne = Ship(context: moc)
                shipOne.name = "Enterprise"
                shipOne.universe = "Star Trek"
                
                let shipTwo = Ship(context: moc)
                shipTwo.name = "Defiant"
                shipTwo.universe = "Star Trek"
                
                let shipThree = Ship(context: moc)
                shipThree.name = "Millenium Falcon"
                shipThree.universe = "Star Wars"
                
                let shipFour = Ship(context: moc)
                shipFour.name = "Executor"
                shipFour.universe = "Star Trek"
                
                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
