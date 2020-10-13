//
//  GenreListView.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct GenreRowView: View {
    
    let genres: [GenreElement]
    
    init(genres: [GenreElement]) {
        self.genres = genres
    }
    
    var body: some View {
        
        ForEach(genres, id: \.id) { genre in
            
            NavigationLink(destination: MovielistView(genre: genre)) {
                
                Image("\(genre.name)")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                Text(genre.name)
                
            }
        }
    }
}

struct GenreListView_Previews: PreviewProvider {
    static var previews: some View {
        GenreRowView(genres: [GenreElement(id: 1, name: "Western")])
    }
}
