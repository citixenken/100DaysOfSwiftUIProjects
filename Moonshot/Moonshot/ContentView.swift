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
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    @State private var showingGridOrList = true
    
    var body: some View {
        NavigationView {
            Group {
                if showingGridOrList {
                    GridLayoutView()
                } else {
                    ListLayoutView()
                }
            }
            .navigationTitle("Moonshot")
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
            .preferredColorScheme(.dark) //locks display to dark mode
            
            .toolbar {
                Button("Toggle View") {
                    showingGridOrList.toggle()
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
