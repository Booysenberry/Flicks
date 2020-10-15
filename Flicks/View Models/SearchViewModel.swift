//
//  SearchViewModel.swift
//  Flicks
//
//  Created by Brad B on 30/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchedMovies = [Movie]()
    @Published var searchedShows = [Show]()
    
    private var fetchedMovies = [MovieList]()
    private var fetchedShows = [TVShowList]()
    
    var currentPage = 1
    
    func checkTotalMovies(movie: String) {
        if fetchedMovies.count < 20 {
            currentPage = currentPage + 1
            fetchMovies(movie: movie)
        }
    }
    
    func checkTotalShows(show: String) {
        if fetchedShows.count < 20 {
            currentPage = currentPage + 1
            fetchShows(show: show)
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
    
    func fetchShows(show: String) {
        
        WebService().searchForShow(show: show, page: currentPage) { show in
            
            if let show = show {
                self.fetchedShows.append(show)
                for show in show.shows {
                    self.searchedShows.append(show)
                }
            }
        }
        if let totalPages = fetchedShows.first?.totalPages {
            if currentPage <= totalPages {
                currentPage += 1
            }
        }
    }
}

