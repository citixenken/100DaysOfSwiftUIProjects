//
//  ContentView.swift
//  Instafilter
//
//  Created by Ken Muyesu on 20/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
        
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...10)
                .onChange(of: blurAmount) { newValue in
                    print("New value is: \(newValue)")
                }
            Button("Click for blur effect"){
                blurAmount = Double.random(in: 0...10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
