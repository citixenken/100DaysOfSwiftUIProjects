//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Ken Muyesu on 19/05/2022.
//

import SwiftUI

struct FilteredList: View {
    //stores fetch request; DOESN'T CREATE!
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in 
            Text("\(singer.wrappedFirstName) \"\(singer.wrappedAliasName)\" \(singer.wrappedLastName)")
        }
    }
    
    init(filter: String) {
       _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "aliasName BEGINSWITH %@", filter))
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
