//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ken Muyesu on 05/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var attempts = 1
    @State private var endGame = false

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "US", "UK"].shuffled()
    
    //correct answer -> 3 flags available for each quiz
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var rotationAmount = 0.0
    
    var body: some View { //opaque return type
        
        ZStack {
            //            LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            //                .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.3, green: 0.6, blue: 0.4), location: 0.5),
                .init(color: Color(red: 0.9, green: 0.6, blue: 0.3), location: 0.5)], center: .topTrailing, startRadius: 200, endRadius: 600)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of...")
                            .titleStyle()
//                            .foregroundStyle(.secondary)
//                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                        //.foregroundColor(.white)
                            .font(.largeTitle.weight(.bold))
                    }
                    
                    ForEach(0..<3) { number in
                            Button {
                                //flag was tapped
                                flagTapped(number)
                                
                                withAnimation {
                                    rotationAmount += 360
                                }
                                
                            } label: {
                                FlagImage(flagName: countries[number])
                                //                            .clipShape(Capsule())
                                //                            .shadow(radius: 20)
                            }
                            .rotation3DEffect(.degrees((number == correctAnswer) ? rotationAmount : 0), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        //in-game alert
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your current score is: \(score)")
        }
        
        //end-game alert
        .alert(scoreTitle, isPresented: $endGame) {
            Button("Restart Game?", action: reset)
        } message: {
            Text("Your final score is: \(score)")
        }
        
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 2
        } else {
            scoreTitle = "Wrong! \n\nThat is the flag of \(countries[number])"
            score -= 3
        }
        showingScore = true
    }
    
    private func askQuestion() {
        if attempts == 10 {
            scoreTitle = "The End!\n"
            endGame = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            attempts += 1
        }
    }
    
    private func reset() {
        score = 0
        attempts = 0
        askQuestion()
    }
}
//FlagImage() View
struct FlagImage: View {
    var flagName: String
    
    var body: some View {
        Image(flagName)
            .renderingMode(.original)
            .cornerRadius(10)
    }
}

//TitleModifier
struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

//extension
extension View {
    func titleStyle() -> some View {
        modifier(TitleModifier())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
