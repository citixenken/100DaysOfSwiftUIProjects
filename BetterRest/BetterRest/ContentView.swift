//
//  ContentView.swift
//  BetterRest
//
//  Created by Ken Muyesu on 20/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        //Text(Date.now, format: .dateTime.year().month().day().weekday().dayOfYear())
        Text(Date.now.formatted(date: .long, time: .complete))
    }
    
    func exampleDate() {
//        var components = DateComponents()
//        components.hour = 10
//        components.minute = 45
//        var date = Calendar.current.date(from: components) ?? Date.now
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour
        let minute = components.minute
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
