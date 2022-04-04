//
//  ContentView.swift
//  Project1Challenge
//
//  Created by Ken Muyesu on 03/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    enum DefaultConversion: String, CaseIterable {
        case metres = "M"
        case kilometres = "KM"
        case feet = "Ft"
        case yards = "Yds"
        case miles = "Mil"
    }
    
    @State private var inputValue: DefaultConversion = .metres
    @State private var outputValue: DefaultConversion = .metres
    @State private var input = ""
    
    //handling input focus for our UI
    @FocusState private var amountIsFocused: Bool
    
    var lengthConverter: Double {
        guard let inputAmount = Double(input) else { return 0 }
        //let inputAmount = Double(input)
        var conversionToMetres = 0.0
        var conversionResult = 0.0
        
        //converting all input types to metres
        switch inputValue {
        case .metres:
            conversionToMetres = inputAmount * 1
        case .kilometres:
            conversionToMetres = inputAmount * 1000
        case .feet:
            conversionToMetres = inputAmount * 0.3048
        case .yards:
            conversionToMetres = inputAmount * 0.9144
        case .miles:
            conversionToMetres = inputAmount * 1609.344
        }
        
        //converting to desired output unit
        switch outputValue {
        case .metres:
            conversionResult = conversionToMetres * 1
        case .kilometres:
            conversionResult = conversionToMetres * 0.001
        case .feet:
            conversionResult = conversionToMetres * 3.28084
        case .yards:
            conversionResult = conversionToMetres * 1.093613
        case .miles:
            conversionResult = conversionToMetres * 0.0006213712
        }
        
        return conversionResult
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Convert:", selection: $inputValue) {
                        ForEach(DefaultConversion.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } header: {
                    Text("select input unit")
                }
                .pickerStyle(.segmented)
                
                Section {
                    TextField("Enter value", text: $input)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                } header: {
                    Text("Input")
                }

                Section {
                    Picker("Convert:", selection: $outputValue) {
                        ForEach(DefaultConversion.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } header: {
                    Text("select output unit")
                }
                .pickerStyle(.segmented)
                
                Section {
                    Text(lengthConverter, format: .number)
                    
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Length Converter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
