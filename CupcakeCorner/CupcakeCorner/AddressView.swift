//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Ken Muyesu on 12/05/2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
            Form {
                Section {
                    TextField("Customer Name", text: $order.name)
                } header: {
                    Text("Name")
                }
                
                Section {
                    TextField("Street Address", text: $order.streetAddress)
                } header: {
                    Text("Street Address")
                }
                
                Section {
                    TextField("City", text: $order.city)
                } header: {
                    Text("City")
                }
                
                Section {
                    TextField("Zip Code", text: $order.zip)
                } header: {
                    Text("Zip")
                        .keyboardType(.numberPad)
                }
                
                Section {
                    NavigationLink {
                        CheckoutView(order: order)
                        
                    } label: {
                        Text("Checkout")
                    }
                } header: {
                    Text("Checkout")
                }
                .disabled(order.hasValidDeliveryAddress == false)
            }
            .navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
        }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
