//
//  ContentView.swift
//  BetterRest
//
//  Created by Ken Muyesu on 20/04/2022.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    //default wake up time
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            //                            LinearGradient(gradient: Gradient(colors: [.yellow, .green, .red]), startPoint: .topLeading, endPoint: .bottomLeading)
            //                                .ignoresSafeArea()
            //                Image("undraw_sleep_analysis")
            //                    .resizable()
            
            Form {
                Section {
                    DatePicker("Wake up time", selection: $wakeUp, displayedComponents: [.hourAndMinute])
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                
                //                VStack(alignment: .leading, spacing: 20) {
                //                    Text("When do you want to wake up?")
                //                        .font(.title2)
                //                        .foregroundColor(.secondary)
                //                    DatePicker("Wake up time", selection: $wakeUp, displayedComponents: [.hourAndMinute])
                //                        .labelsHidden()
                //                }
//                Spacer()
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .padding()
                } header: {
                    Text("Desired amount of sleep?")
                        .font(.title2)
                }
                
                //                VStack(alignment: .leading, spacing: 20) {
                //                    Text("Desired amount of sleep?")
                //                        .font(.title2)
                //                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                //                        .padding()
                //                }
                
                Section {
//                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount.formatted()) cups", value: $coffeeAmount, in: 1...50, step: 1)
//                        .padding()
                    Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount.formatted()) cups", selection: $coffeeAmount) {
                        ForEach(0..<51){
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                    //.pickerStyle(.menu)
                } header: {
                    Text("Amount of coffeee consumed?")
                        .font(.title2)
                }
                //                VStack(alignment: .leading, spacing: 20) {
                //                    Text("Amount of coffeee consumed?")
                //                        .font(.title2)
                //                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount.formatted()) cups", value: $coffeeAmount, in: 1...50, step: 1)
                //                        .padding()
                //                }
                
//                VStack(alignment: .center, spacing: 20) {
//                    Button("Calculate", action: calculateBedTime)
//                        .font(.title)
//                        .padding()
//                    //.border(Color.purple, width: 5)
//                        .foregroundColor(.white)
//                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                        .cornerRadius(8)
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
//                }
                
                Section {
                    Text(calculateBedTime())
                        .font(.title)
                        .foregroundColor(Color.green)
                } header: {
                    Text("Recommended bedtime")
                        .font(.title2)
                        .foregroundColor(.primary)
                        
                }
                
                
//                Spacer()
            }
            //                .toolbar {
            //                    Button("Calculate", action: calculateBedTime)
            //                }
            .navigationTitle("BetterRest")
            .navigationBarTitleDisplayMode(.inline)
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("OK") {}
//            } message: {
//                Text(alertMessage)
//            }
            
        }
        
    }
    
    private func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal sleep time is..."
            //alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error!"
            //alertMessage = "There was a problem calculating your bedtime."
            return "There was a problem calculating your bedtime."
        }
        
        //showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
