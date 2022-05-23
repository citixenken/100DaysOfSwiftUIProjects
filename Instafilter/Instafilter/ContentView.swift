//
//  ContentView.swift
//  Instafilter
//
//  Created by Ken Muyesu on 20/05/2022.
//


import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select image") {
                showingImagePicker = true
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(16)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
