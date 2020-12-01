//
//  FilteredMovieViewModel.swift
//  Flicks
//
//  Created by Brad B on 16/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class FilteredMovieGridViewModel: ObservableObject {
    
    @Published var label = "Trending"
    @Published var icon = "flame.fill"
    @Published var movies = [Movie]()
    private var filteredMovies = [MovieList]()
    
    var currentPage = 1
    
    var filter = "popularity"
    
    
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
                
            }
        }
    }
    
    func filterResults(filterBy: String) {
        
        movies.removeAll()
        currentPage = 1
        fetchMovies(filter: filter)
        
        switch filterBy {
        case "popularity":
            label = "Trending"
            icon = "flame.fill"
        case "vote_average":
            label = "Top Rated"
            icon = "star.fill"
        case "primary_release_date":
            label = "Newest"
            icon = "calendar"
        case "revenue":
            label = "Revenue"
            icon = "dollarsign.square.fill"
        default:
            label = "Most Popular"
            icon = "flame.fill"
        }
    }
    
    func topRated() {
        filter = "vote_average"
        filterResults(filterBy: filter)
    }
    
    func popular() {
        filter = "popularity"
        filterResults(filterBy: filter)
    }
    
    func releaseDate() {
        filter = "primary_release_date"
        filterResults(filterBy: filter)
    }
    
    func highestGrossing() {
        filter = "revenue"
        filterResults(filterBy: filter)
    }
    
}

