//
//  DetailViewModel.swift
//  Flicks
//
//  Created by Brad B on 13/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    @Published var fetchedMovie: Movie?
    @Published var recommendedMovies = [Movie]()
    
    func getMovieDetails(id: Int) {
        
        WebService().getMovieDetails(movie: id) { movie in
            
            if let movie = movie {
                self.fetchedMovie = movie
    
            }
        }
    }
    
    
    func getRecommendedMovies(movie: Int) {
        
        WebService().getRecommendedMovies(movie: movie) { recommendedMovies in
            
            if let movies = recommendedMovies?.results {
            
                for movie in movies {
                    self.recommendedMovies.append(movie)

                }
            }
        }
    }
}

