//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ken Muyesu on 12/05/2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Text("Checkout View")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
