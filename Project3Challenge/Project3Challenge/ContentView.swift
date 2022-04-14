//
//  ContentView.swift
//  Project3Challenge
//
//  Created by Ken Muyesu on 11/04/2022.
//

import SwiftUI

struct ContentView: View {
    //@State var gameOptions = ["Rock", "Paper", "Scissors"].shuffled()
    let gameOptions = ["Rock", "Paper", "Scissors"]
    
    
    @State private var correctChoice = Int.random(in: 0...2)
    
    @State private var gameMode = Bool.random()
    
    var winOrLoseText: String {
        if gameMode == true {
            return "WIN!"
        } else {
            return "LOSE!"
        }
    }
    
    @State private var score = 0
    
    @State private var scoreTitle = ""
    
    @State private var displayScore = false
    
    @State private var numberOfTries = 0
    
    @State private var endRound = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Text("Brain Bender")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.primary)
                Spacer()
                
                VStack (spacing: 20) {
                    //Spacer()
                    VStack {
                        Text("Game has selected...")
                            .font(.title)
                            .foregroundStyle(.ultraThickMaterial)
                        Text("\(gameOptions[correctChoice])!!!")
                            .font(.title.weight(.heavy))
                            .foregroundColor(Color(.darkGray))
                        
                        Spacer()
                        
                        Text("Now, try to")
                        Text("\(winOrLoseText)")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(gameMode ? Color.green : Color.red)
                        
                        //                        Text("\(self.gameMode ? "Win" : "Lose")")
                        //                            .font(.title.bold())
                        //                            .foregroundColor(self.gameMode ? .green : .red)
                        //                        Text("this round")
                    }
                    
                    Spacer()
                    
                    ForEach(0..<3) { choice in
                        Button {
                            self.choiceTapped(choice)
                            playGame()
                        } label: {
                            Image(self.gameOptions[choice])
                                .resizable()
                            //.renderingMode(.original)
                                .frame(width: 250, height: 140)
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                //                .padding(.vertical, 20)
                .padding()
                .background(.ultraThinMaterial)
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
        .alert(scoreTitle, isPresented: $displayScore) {
            Button("Continue", action: playGame)
        } message: {
            Text("Current score is: \(score)")
        }
        
        .alert(scoreTitle, isPresented: $endRound) {
            Button("Restart Game?", action: restartGame)
        } message: {
            Text("Final score: \(score)")
        }
    }
    
    func choiceTapped(_ choice: Int) {
        
        if gameMode {
            //All the losing scenarios
            if choice == correctChoice {
                scoreTitle = "Lose - Items the same"
            } else if choice == 2 && correctChoice == 0 {
                scoreTitle = "Lose - Player chose Scissors, Siri chose Rock"
            } else if choice == 0 && correctChoice == 1 {
                scoreTitle = "Lose - Player chose Rock, Siri chose Paper"
            } else if choice == 1 && correctChoice == 2 {
                scoreTitle = "Lose - Player chose Paper, Siri chose Scissors"
            } else {
                scoreTitle = "Win! Add Points"
                score += 1
            }
            
            displayScore = true
            
        } else {
            if choice == correctChoice {
                scoreTitle = "Win - Items the same"
                score += 1
            } else if choice == 2 && correctChoice == 0 {
                scoreTitle = "Win - Player chose Scissors, Siri chose Rock"
                score += 1
            } else if choice == 0 && correctChoice == 1 {
                scoreTitle = "Win - Player chose Rock, Siri chose Paper"
                score += 1
            } else if choice == 1 && correctChoice == 2 {
                scoreTitle = "Win - Player chose Paper, Siri chose Scissors"
                score += 1
            } else {
                scoreTitle = "Lose - No Points"
            }
        }
        //gameMode = Bool.random()
        displayScore = true
    }
    
    
    private func playGame() {
        if numberOfTries == 10 {
            scoreTitle = "The End!"
            endRound = true
        } else {
            correctChoice = Int.random(in: 0...2)
            numberOfTries += 1
            gameMode = Bool.random()
        }
    }
    
    private func restartGame() {
        score = 0
        numberOfTries = 0
        playGame()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
