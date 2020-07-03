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
    
    var currentPage = 1
    
    func checkTotalMovies(genre: Int) {
        if fetchedMovies.count < 20 {
            currentPage = currentPage + 1
            fetchMovies(genre: genre)
        }
    }
    
    func fetchMovies(genre: Int) {
        
        WebService().getMoviesByGenre(genre: genre, page: currentPage) { movie in
            
            if let movie = movie {
                self.fetchedMovies.append(movie)
                for movie in movie.movies {
                    self.movies.append(movie)
                }
            }
        }
        if let totalPages = fetchedMovies.first?.totalPages {
            if currentPage <= totalPages {
                currentPage += 1
                print(currentPage)
            }
        }
    }
}


