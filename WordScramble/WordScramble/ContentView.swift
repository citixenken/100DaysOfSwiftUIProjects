//
//  ContentView.swift
//  WordScramble
//
//  Created by Ken Muyesu on 25/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    //error handling
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word:", text: $newWord)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
                
                Section {
                    Text("\(score)")
                } header: {
                    Text("player's score")
                }
            }
            .navigationTitle(rootWord)
            //.navigationBarTitleDisplayMode(.inline)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            //restart game
            .toolbar {
                Button("New Word") {
                    chooseNewWord()
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        //disallow answers that are shorter than 3 letters or are just our start word
        if answer.count < 3 {
            wordError(title: "Word is too short", message: "Try a longer word")
            return
        }
        if answer == rootWord {
            wordError(title: "Word is duplicate of '\(rootWord)'", message: "Try another word.")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "Not a real word. You can't just make up random words.")
            return
        }
        
        withAnimation {
            //insert at start of the array
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
        
        //scoring - Can be better!
        if answer.count > 5 {
            return score += 3
        } else if answer.count > 3 {
            return score += 2
        } else {
            return score -= 1
        }
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "defaults"
                return
            }
        }
        fatalError("Couldn't not load start.txt from the App Bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func chooseNewWord() {
        usedWords = [String]()
        newWord = ""
        score = 0
        startGame()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
