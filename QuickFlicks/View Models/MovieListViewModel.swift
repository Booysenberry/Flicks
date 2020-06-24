//
//  ShortListViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 12/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    @Published var movies = [Movie]()
    
    private var fetchedMovies = [MovieList]()
    
    var page = 1
    
    func fetchMovies(genre: Int) {
        
        WebService().getMoviesByGenre(genre: genre, page: page) { movie in
            
            if let movie = movie {
                
                self.fetchedMovies.append(movie)
                
                for movie in movie.movies {
                    self.movies.append(movie)
                    
                }
            }
        }
        page += 1
        print(page)
    }
}


