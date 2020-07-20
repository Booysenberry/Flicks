//
//  CastView.swift
//  QuickFlicks
//
//  Created by Brad B on 6/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct CastView: View {
    
    var cast: [Cast]
    
    var body: some View {
        
        HStack {
            
            ForEach(cast, id: \.id) { actor in
                
                VStack {
                    
                    URLImage(url: "\(actor.profileURL)")
                        .clipShape(Circle())
                        .frame(width: 92, height: 136)
                    
                    Text("\(actor.name!)")
                        .font(.footnote)
                }
            }
        }
    }
}

struct CastView_Previews: PreviewProvider {
    static var previews: some View {
        CastView(cast: [Cast(id: 1, name: "Edward Norton", profilePath: "/eIkFHNlfretLS1spAcIoihKUS62.jpg")])
    }
}

