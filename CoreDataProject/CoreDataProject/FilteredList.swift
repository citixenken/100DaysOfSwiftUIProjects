//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Ken Muyesu on 19/05/2022.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    //stores fetch request; DOESN'T CREATE!
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    //MARK:  @escaping -> To be used later on
    //TODO: @ViewBuilder -> Can provide many views as you want to
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
       _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
