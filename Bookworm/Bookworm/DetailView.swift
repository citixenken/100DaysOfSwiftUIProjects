//
//  DetailView.swift
//  Bookworm
//
//  Created by Ken Muyesu on 17/05/2022.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
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
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(book: <#T##Book#>)
//    }
//}
