//
//  DetailView.swift
//  Bookworm
//
//  Created by Ken Muyesu on 17/05/2022.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Thriller")
                    .resizable()
                    .scaledToFit()
                
                Text((book.genre?.uppercased()) ?? "THRILLER")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.8))
                    .clipShape(Capsule())
                    .offset(x: -10, y: -10)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text("Added on: \(book.date?.formatted(date: .abbreviated, time: .shortened) ?? "Cannot define exact date added")")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        
        .alert("Delete '\(book.title ?? "Unknown book")'?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel, action: {}) //empty action
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        
        dismiss()
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(book: <#T##Book#>)
//    }
//}
