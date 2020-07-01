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
    
    var currentPage = 1
    
    func checkTotalMovies(movie: String) {
        if fetchedMovies.count < 20 {
            currentPage = currentPage + 1
            fetchMovies(movie: movie)
        }
    }
    
    func fetchMovies(movie: String) {
        
        WebService().searchForMovie(movie: movie, page: currentPage) { movie in
            
            if let movie = movie {
                self.fetchedMovies.append(movie)
                for movie in movie.movies {
                    self.searchedMovies.append(movie)
                }
            }
        }
        if let totalPages = fetchedMovies.first?.totalPages {
            if currentPage <= totalPages {
                currentPage += 1
            }
        }
    }
}

