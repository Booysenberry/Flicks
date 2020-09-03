//
//  FilteredMovieViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 16/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class FilteredMovieGridViewModel: ObservableObject {
    
    @Published var movies = [Movie]()
    private var filteredMovies = [MovieList]()
   
    var currentPage = 1
    
    init() {
        fetchMovies(filter: "popularity")
        currentPage = 2
    }
    
    func checkTotalMovies(filter: String) {

        if filteredMovies.count < 20 {
            fetchMovies(filter: filter)
        }
    }
    
    func fetchMovies(filter: String) {
        
        print("Starting: \(currentPage)")
        
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
                
                print("Ending: \(currentPage)")

            }
        }
    }
}

