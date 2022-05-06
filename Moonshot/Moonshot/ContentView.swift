//
//  ContentView.swift
//  Moonshot
//
//  Created by Ken Muyesu on 06/05/2022.
//

import SwiftUI

struct ContentView: View {
    let astronauts = Bundle.main.decode("astronauts.json")
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
