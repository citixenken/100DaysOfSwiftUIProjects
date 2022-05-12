//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ken Muyesu on 11/05/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 1...20)
                    
                } header: {
                    Text("Cake type")
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation(.interactiveSpring()))
                } header: {
                    Text("Cake Additions")
                }
                
                Section {
                    if order.specialRequestEnabled {
                        Toggle("Add frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)

                    }
                } header: {
                    Text(order.specialRequestEnabled ? "Frosting and Sprinkles" : "")
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Address information")
                    }
                } header: {
                    Text("Delivery details")
                }
                
                
            }
            .navigationTitle("Cupcake Corner")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
