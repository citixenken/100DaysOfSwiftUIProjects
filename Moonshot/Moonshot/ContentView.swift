//
//  ContentView.swift
//  Moonshot
//
//  Created by Ken Muyesu on 06/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    //when using generics; explicitly declare type annotation
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        Text("\(astronauts.count)")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
