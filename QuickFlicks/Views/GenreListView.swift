//
//  GenreListView.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct GenreListView: View {
    
    let genres: [GenreViewModel]
    
    init(genres: [GenreViewModel]) {
        
        self.genres = genres
        
    }
    
    var body: some View {
        
        List {
            
            ForEach(self.genres, id: \.id) { genre in
            
                Text(genre.name)
                    
            }
        }
    }
}

struct GenreListView_Previews: PreviewProvider {
    static var previews: some View {
        GenreListView(genres: [GenreViewModel(genre: GenreElement(id: 1, name: "Romance"))])
    }
}
