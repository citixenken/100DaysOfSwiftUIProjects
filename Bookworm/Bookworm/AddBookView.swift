//
//  AddBookView.swift
//  Bookworm
//
//  Created by Ken Muyesu on 16/05/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 4
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Romance", "Fiction", "Fantasy", "Thriller", "Poetry", "Non-Fiction", "History", "Mystery"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                        .disableAutocorrection(true)
                    TextField("Author's name", text: $author)
                        .disableAutocorrection(true)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Book Details")
                }
                
                Section {
                    TextEditor(text: $review)
                        .disableAutocorrection(true)
                    RatingView(rating: $rating)
                    
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text(String($0))
//
//                        }
//                    }
                } header: {
                    Text("Write a Book Review")
                }
                
                Section {
                    Button("Save") {
                        //add the book
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date.now
                        
                        try? moc.save()
                        
                        //dismiss sheet presentation after save
                        dismiss()
                    }
                }
                .disabled(hasValidBookInfo == false)
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    //form validation
    var hasValidBookInfo: Bool {
        if (title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) || (author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) || (genre.isEmpty) || (review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            return false
        }
        return true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
