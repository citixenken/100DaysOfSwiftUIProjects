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
    @State private var aliasNameFilter = "K"
    
    var body: some View {
        VStack {
            //list of matching singers
            FilteredList(filter: aliasNameFilter)
            
            Button("Add Singers") {
                let kendrick = Singer(context: moc)
                kendrick.firstName = "Kendrick"
                kendrick.lastName = "Lamar"
                kendrick.aliasName = "Kung-Fu Kenny"
                
                let postmalone = Singer(context: moc)
                postmalone.firstName = "Austin"
                postmalone.lastName = "Post"
                postmalone.aliasName = "Post Malone"
                
                let beyonce = Singer(context: moc)
                beyonce.firstName = "Beyonce"
                beyonce.lastName = "Knowles"
                beyonce.aliasName = "Beyonce"
                
                try? moc.save()

            }
            
            Button("Show P") {
                aliasNameFilter = "P"
            }
            
            Button("Show B") {
                aliasNameFilter = "B"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
