//
//  ContentView.swift
//  Project1Challenge
//
//  Created by Ken Muyesu on 03/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = 0.0
    @State private var defaultConversion = ["Minutes", "Hours", "Days"]
//    enum conversionFormats {
//        case minutes, hours, days
//    }
    var outputUnit: Double {
        return -1
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter value in seconds", value: $inputUnit, format: .number)
                    
                } header: {
                    Text("Input in seconds")
                }
                
                Section {
                    Picker("Convert to:", selection: $defaultConversion) {
                        ForEach(defaultConversion, id: \.self) {
                            Text("\($0)")
                        }
                    }
                } header: {
                    Text("select unit to convert input to")
                }
                .pickerStyle(.segmented)
                
                Section {
                    Text(outputUnit, format: .number)
                    
                } header: {
                    Text("Output")
                }
                
            }
            .navigationTitle("Time Converter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
