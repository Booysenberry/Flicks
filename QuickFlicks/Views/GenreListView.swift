//
//  GenreListView.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct GenreListView: View {
    
    let genres: [GenreElement]
    
    init(genres: [GenreElement]) {
        
        self.genres = genres
        
    }
    
    var body: some View {
        
        ForEach(genres, id: \.id) { genre in
            
            NavigationLink(destination: ShortlistView(genre: genre)) {
                
                Text(genre.name)
                
            }
        }
    }
}


struct GenreListView_Previews: PreviewProvider {
    static var previews: some View {
        GenreListView(genres: [GenreElement(id: 1, name: "Western")])
    }
}
