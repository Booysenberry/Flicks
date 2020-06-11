//
//  ShortListViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 12/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class ShortListViewModel: ObservableObject {
    
    @Published var fetchedMovies = [Result]()
    
    func fetchMovies(genre: Int) {
        
        WebService().getMoviesByGenre(genre: genre) { movie in
            
            if let movie = movie?.results {
                
                self.fetchedMovies.append(contentsOf: movie)
                
            }
        }
    }
}
