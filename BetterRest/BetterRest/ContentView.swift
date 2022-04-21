//
//  ContentView.swift
//  BetterRest
//
//  Created by Ken Muyesu on 20/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.yellow, .green, .mint]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                VStack {
                    //Spacer()
                    Text("When do you want to wake up?")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    DatePicker("Wake up time", selection: $wakeUp, in: wakeUp..., displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                    //Spacer()
                    
                    Text("Desired amount of sleep?")
                        .font(.title2)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .padding()
                    
                    Text("Amount of coffeee consumed?")
                        .font(.title2)
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount.formatted()) cups", value: $coffeeAmount, in: 1...50, step: 1)
                        .padding()
                    
                    Button("Calculate", action: calculateBedTime)
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(16)
                    
                    Spacer()
                }
                .toolbar {
                    Button("Calculate", action: calculateBedTime)
                }
                .navigationTitle("BetterRest")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private func calculateBedTime() {
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
