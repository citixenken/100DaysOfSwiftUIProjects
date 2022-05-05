//
//  ContentView.swift
//  MultiplierChallenge
//
//  Created by Ken Muyesu on 04/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var inputA = 1
    @State private var inputB = 1
    @State private var outputAnswer = 1

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("\(inputA.formatted())", selection: $inputA) {
                        ForEach(0..<11) {
                            Text("\($0)")
                        }
                    }
                } header: {
                    Text("Enter first param")
                }
                Section {
                    Picker("\(inputB.formatted())", selection: $inputB) {
                        ForEach(0..<11) {
                            Text("\($0)")
                        }
                    }
                } header: {
                    Text("Enter second param")
                }
                Section {
                    Text(calculatedOutput())
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Multiplier")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func calculatedOutput() -> String {
        return String(inputA * inputB)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
