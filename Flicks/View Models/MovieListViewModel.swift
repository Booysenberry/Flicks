//
//  ShortListViewModel.swift
//  Flicks
//
//  Created by Brad B on 12/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    @Published var movies = [Movie]()
    @Published var label = "Trending"
    @Published var icon = "flame.fill"
    
    private var fetchedMovies = [MovieList]()
    
    var currentPage = 1
    var filter = "popularity"
    var genre = 1
    
    func checkTotalMovies(genre: Int, filter: String) {
        if fetchedMovies.count < 20 {
            currentPage = currentPage + 1
            fetchMovies(genre: genre, filter: filter)
        }
    }
    
    func fetchMovies(genre: Int, filter: String) {
        
        WebService().getMoviesByGenre(filter: filter, genre: genre, page: currentPage) { movie in
            
            if let movie = movie {
                self.fetchedMovies.append(movie)
                for movie in movie.movies {
                    self.movies.append(movie)
                    self.genre = genre
                }
            }
        }
        if let totalPages = fetchedMovies.first?.totalPages {
            if currentPage <= totalPages {
                currentPage += 1

            }
        }
    }
    
    func filterResults(filterBy: String, byGenre: Int) {
        
        movies.removeAll()
        currentPage = 1
        fetchMovies(genre: genre, filter: filter)
        
        switch filterBy {
        case "popularity":
            label = "Trending"
            icon = "flame.fill"
            genre = byGenre
        case "vote_average":
            label = "Top Rated"
            icon = "star.fill"
            genre = byGenre
        case "primary_release_date":
            label = "Newest"
            icon = "calendar"
            genre = byGenre
        case "revenue":
            label = "Revenue"
            icon = "dollarsign.square.fill"
            genre = byGenre
        default:
            label = "Most Popular"
            icon = "flame.fill"
            genre = byGenre
        }
    }
    
    func topRated() {
        filter = "vote_average"
        filterResults(filterBy: filter, byGenre: genre )
    }
    
    func popular() {
        filter = "popularity"
        filterResults(filterBy: filter, byGenre: genre)
    }
    
    func releaseDate() {
        filter = "primary_release_date"
        filterResults(filterBy: filter, byGenre: genre)
    }
    
    func highestGrossing() {
        filter = "revenue"
        filterResults(filterBy: filter, byGenre: genre)
    }
}


