//
//  FilteredMovieViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 16/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class FilteredMovieViewModel: ObservableObject {
    
    init() {
        fetchMovies(filter: "popularity")
    }
    
    @Published var movies = [Movie]()
    
    private var filteredMovies = [MovieList]()
    
    var currentPage = 1
    
    func checkTotalMovies(filter: String) {
        if filteredMovies.count < 20 {
            currentPage = currentPage + 1
            fetchMovies(filter: filter)
        }
    }
    
    func fetchMovies(filter: String) {
        
        WebService().getMoviesByFilter(filter: filter, page: currentPage) { movie in
            
            if let movie = movie {
                self.filteredMovies.append(movie)
                for movie in movie.movies {
                    self.movies.append(movie)
                }
            }
        }
        if let totalPages = filteredMovies.first?.totalPages {
            if currentPage <= totalPages {
                currentPage += 1
                print(currentPage)
            }
        }
    }
}

