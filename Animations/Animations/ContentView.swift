//
//  ContentView.swift
//  Animations
//
//  Created by Ken Muyesu on 26/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    let letters = Array("Hi there, @citixenken")
    
    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .topTrailing, endPoint: .bottomLeading)
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 16))
//            .offset(dragAmount)
//            .gesture(DragGesture()
//                        .onChanged { dragAmount = $0.translation }
//                        .onEnded { _ in
//                            withAnimation {
//                                dragAmount = .zero
//                            }
//                        }
//            )
        
        //implicit animation
        //.animation(.spring(), value: dragAmount)
        
        HStack (spacing: 0) {
            ForEach(0..<letters.count) { pos in
                Text(String(letters[pos]))
                    .padding(2)
                    .font(.title)
                    .background(enabled ? .red : .blue)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(pos) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
