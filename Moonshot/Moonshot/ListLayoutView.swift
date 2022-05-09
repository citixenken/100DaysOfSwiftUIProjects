//
//  ListLayoutView.swift
//  Moonshot
//
//  Created by Ken Muyesu on 09/05/2022.
//

import SwiftUI

struct ListLayoutView: View {
    
    //when using generics; explicitly declare type annotation
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
    //                            Text("\(mission.displayName) Detail View")
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.orange)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.lightBackground))
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
//        .ignoresSafeArea()
    }
}

struct ListLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        ListLayoutView()
    }
}
