//
//  ShortListViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 12/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    @Published var fetchedMovies = [Movie]()
    
    func fetchMovies(genre: Int) {
        
        WebService().getMoviesByGenre(genre: genre) { movie in
            
            if let movie = movie?.movie {
                
                self.fetchedMovies.append(contentsOf: movie)
                
            }
        }
    }
}

class MoviesViewModel {
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var id: Int {
        return movie.id
    }
    
    var movieTitle: String {
        return movie.title
    }
    
    var movieOverview: String {
        return movie.overview
    }
    
    var movieReleaseDate: String {
        
        var date = String()
        
        if movie.releaseDate != nil {
            date = movie.releaseDate ?? ""
        }
        return date
    }
    
    var votes: String {
        return String(movie.voteCount)
    }
    
    var rating: String {
        return "\(Int(movie.voteAverage * 10))%"
    }
    
    var smallPosterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w92\(movie.posterPath ?? "")")!
    }
    
    var largePosterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")")!
    }
}
