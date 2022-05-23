//
//  ContentView.swift
//  Instafilter
//
//  Created by Ken Muyesu on 20/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Tap here for The Rainbow Experience!")
                    .frame(width: 350, height: 350)
                    .background(backgroundColor)
                    .onTapGesture {
                        showingConfirmation = true
                    }
                    .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                        Button("Red") { backgroundColor = .red }
                        Button("Orange") { backgroundColor = .orange }
                        Button("Yellow") { backgroundColor = .yellow }
                        Button("Green") { backgroundColor = .green }
                        Button("Blue") { backgroundColor = .blue }
                        Button("Indigo") { backgroundColor = .indigo }
                        Button("Purple") { backgroundColor = .purple }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("Select a new color")
                    }
            }
            .navigationTitle("Rainbow Colours")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
