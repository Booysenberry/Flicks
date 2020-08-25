//
//  FilmographyView.swift
//  QuickFlicks
//
//  Created by Brad B on 26/08/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct FilmographyView: View {
    
    var cast: Cast
    
    var body: some View {
        
        HStack {
            
            URLImage(url: "\(cast.profileURL)", type: "cast")
                .clipShape(Circle())
                .frame(width: 92, height: 136)
            
            Text("\(cast.name!)")
                .font(.title)
            
        }.padding()
        Spacer()
    }
}



struct FilmographyView_Previews: PreviewProvider {
    static var previews: some View {
        FilmographyView(cast: Cast(id: 1, name: "Edward Norton", profilePath: "/eIkFHNlfretLS1spAcIoihKUS62.jpg"))
    }
}
