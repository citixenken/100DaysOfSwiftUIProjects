//
//  MissionView.swift
//  Moonshot
//
//  Created by Ken Muyesu on 07/05/2022.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                    
                        //60% of the available screen width
                        .frame(maxWidth: geo.size.width * 0.6)
                    
                        .padding(.top)
                    
//                    Divider ()
                    
                    VStack {
                        Text("Launch date: \(mission.formattedLaunchDate)")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 1)
                            .padding(.vertical)
                            .foregroundColor(.lightBackground)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 1)
                            .padding(.vertical)
                            .foregroundColor(.lightBackground)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
//                    Divider ()

                    // MARK: - Pending implementation -> Push to a new SwiftUI view
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
//                                    Text("\(crewMember.astronaut.name) details")
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(Circle())
                                            .overlay(
                                            Circle()
                                                .strokeBorder(.white, lineWidth: 2))
                                    }
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundColor(crewMember.role == "Commander" ? .green : .secondary)

                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    
    static var previews: some View {
        MissionView(mission: missions[4], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
