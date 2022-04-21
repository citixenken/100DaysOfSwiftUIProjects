//
//  ContentView.swift
//  BetterRest
//
//  Created by Ken Muyesu on 20/04/2022.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.yellow, .green, .red]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea()
//                Image("undraw_sleep_analysis")
//                    .resizable()
                VStack {
                    //Spacer()
                    Text("When do you want to wake up?")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    DatePicker("Wake up time", selection: $wakeUp, displayedComponents: [.date, .hourAndMinute])
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
                        .cornerRadius(8)
                    
                    Spacer()
                }
//                .toolbar {
//                    Button("Calculate", action: calculateBedTime)
//                }
                .navigationTitle("BetterRest")
                .navigationBarTitleDisplayMode(.inline)
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") {}
                } message: {
                    Text(alertMessage)
                }
            }
        }
    }
    
    private func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal sleep time is..."
            alertMessage = sleepTime.formatted(date: .complete, time: .shortened)
            
        } catch {
            alertTitle = "Error!"
            alertMessage = "There was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
