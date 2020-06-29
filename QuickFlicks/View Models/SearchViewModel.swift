//
//  SearchViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 30/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchedMovies = [Movie]()
    
    private var fetchedMovies = [MovieList]()
    
    func fetchMovies(movie: String) {
        
        WebService().searchForMovie(movie: movie) { movie in
            
            if let movie = movie {
                
                self.fetchedMovies.append(movie)
                
                for movie in movie.movies {
                    
                    self.searchedMovies.append(movie)
                    print(self.searchedMovies)
                    
                }
            }
        }
    }
}

