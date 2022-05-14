//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ken Muyesu on 12/05/2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var confirmationTitle = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is: \(order.cost, format: .currency(code: "KES"))")
                    .padding()
                
                Button("Place Order") {
                    //Handling async-await functions
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle, isPresented: $showingConfirmation){
            Button("OK"){
                
            }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order.")
            return
        }
        //How to send the data -> test server: reqres.in
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        //Making network request
        do {
            let(data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            //handle the result
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank you!"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            
        } catch {
            print("Checkout failed!")
            //error handling
            confirmationTitle = "Sorry!"
            confirmationMessage = "Your order didn't go through. Check your network connectivity and retry."
            showingConfirmation = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
