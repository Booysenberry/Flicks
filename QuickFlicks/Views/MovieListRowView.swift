//
//  ShortlistRowView.swift
//  QuickFlicks
//
//  Created by Brad B on 13/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct MovielistRowView: View {
    
    var movies: MoviesViewModel
    
    var body: some View {
        
        HStack {
            
            URLImage(url: "\(movies.smallPosterURL)")
            
            VStack(alignment: .leading) {
                
                Text(movies.movieTitle)
                    .font(.headline)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Text(movies.rating)
                            .font(.callout)
                    }
                    
                    HStack {
                        
                        Image(systemName: "person.fill")
                        
                        Text(movies.votes)
                            .font(.callout)
                        
                    }
                }
            }
        }
    }
}

struct MovielistRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovielistRowView(movies: MoviesViewModel(movie: Movie.example))
    }
}

