//
//  ContentView.swift
//  WeSplit
//
//  Created by Ken Muyesu on 01/04/2022.
//

import SwiftUI

struct ContentView: View {
    //default values
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    
    //handling input focus for our UI
    @FocusState private var amountIsFocused: Bool
    
    
    //let tipPercentages = [5, 10, 15, 20, 25, 0]
    
    //computed property
    var totalPerPerson: Double {
        //calculate here
        let peopleCount = Double(numberOfPeople + 2) //compensates on the two (2) places advantage
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount / 100) * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var grandTotal: Double {
        return totalPerPerson * Double(numberOfPeople + 2) //compensates on the two (2) places advantage
    }
    
    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "KSh.")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Amount") //capitalized by default
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                .pickerStyle(.automatic)
                
                Section {
                    Text(grandTotal, format: currencyFormatter)
                } header: {
                    Text("Grand Total")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormatter)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total Amount per Person")
                }
            }
            .navigationTitle("WeSplit")
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
        ZStack { //solves the preview crashing issue
            ContentView()
        }
    }
}
