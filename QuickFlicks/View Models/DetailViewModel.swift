//
//  DetailViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 13/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var fetchedMovie = [Result]()
    
    func getMovieDetails(id: Int) {

        WebService().getMovieDetails(movie: id) { movie in

            if let movie = movie {
                self.fetchedMovie = [movie]
            }
        }
    }
}
