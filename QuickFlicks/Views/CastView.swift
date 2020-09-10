//
//  CastView.swift
//  QuickFlicks
//
//  Created by Brad B on 6/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct CastView: View {
    
    var cast: [Actors]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                
                ForEach(cast, id: \.id) { actor in
                    
                    NavigationLink(destination: FilmographyView(cast: actor)) {
                        
                        VStack {
                            
                            URLImage(url: "\(actor.profileURL)", type: "cast")
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.gray, lineWidth: 2))
                                .frame(width: 92, height: 136)
                            
                            Text("\(actor.name!)")
                                .lineLimit(1)
                                .font(.footnote)
                            
                        }.frame(width: 100, height: 200, alignment: .top)
                    }
                }
            }
        }
    }
}

struct CastView_Previews: PreviewProvider {
    static var previews: some View {
        CastView(cast: [Actors(id: 1, name: "Edward Norton", profilePath: "/eIkFHNlfretLS1spAcIoihKUS62.jpg")])
    }
}

