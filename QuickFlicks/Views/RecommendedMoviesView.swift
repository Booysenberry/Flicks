//
//  RecommendedMoviesView.swift
//  QuickFlicks
//
//  Created by Brad B on 10/09/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct RecommendedMoviesView: View {
    
    var movies: [Movie]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            // Recommended movies
            HStack(spacing: 20) {
                ForEach(movies, id:\.uniqueID) { movie in
                    
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        
                        MovieGridItemView(movies: movie)
                        
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct RecommendedMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedMoviesView(movies: [Movie.example])
    }
}
