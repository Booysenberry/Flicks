//
//  ShortListViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 12/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    @Published var fetchedMovies = [Movie]()
    
    func fetchMovies(genre: Int) {
        
        WebService().getMoviesByGenre(genre: genre) { movie in
            
            if let movie = movie?.movie {
                
                self.fetchedMovies.append(contentsOf: movie)
                
            }
        }
    }
}
