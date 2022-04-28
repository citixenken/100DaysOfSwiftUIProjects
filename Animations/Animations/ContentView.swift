//
//  ContentView.swift
//  Animations
//
//  Created by Ken Muyesu on 26/04/2022.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
//    @State private var dragAmount = CGSize.zero
//    @State private var enabled = false
//    let letters = Array("Hi there, @citixenken")
    
    @State private var isShowingMint = false
    
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
        
//        HStack (spacing: 0) {
//            ForEach(0..<letters.count) { pos in
//                Text(String(letters[pos]))
//                    .padding(2)
//                    .font(.title)
//                    .background(enabled ? .red : .blue)
//                    .offset(dragAmount)
//                    .animation(.default.delay(Double(pos) / 20), value: dragAmount)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { dragAmount = $0.translation }
//                .onEnded { _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
        
        
//        VStack {
//            Button(isShowingMint ? "Tapped!" : "Tap here") {
//                withAnimation {
//                    isShowingMint.toggle()
//                }
//            }
//            if isShowingMint {
//                Rectangle()
//                    .fill(.mint)
//                    .frame(width: 200, height: 200)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
//            }
//        }
        
        ZStack {
            Rectangle()
                .fill(.orange)
                .frame(width: 300, height: 300)
            
            if isShowingMint {
                Rectangle()
                    .fill(.mint)
                    .frame(width: 300, height: 300)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingMint.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
