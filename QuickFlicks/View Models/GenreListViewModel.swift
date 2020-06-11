//
//  GenreViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class GenreListViewModel: ObservableObject {
    
    @Published var fetchedGenres = [GenreViewModel]()
    
    init() {
        fetchGenres()
    }
    
    func fetchGenres() {
        
        WebService().getGenres { genres in
            
            if let genres = genres?.genres {
                
                self.fetchedGenres = genres.map(GenreViewModel.init)
                print(self.fetchedGenres)
        
            }
        }
    }
}

class GenreViewModel {
    
    var id = UUID()
    
    var genre: GenreElement
    
    init(genre: GenreElement) {
        self.genre = genre
    }
    
    var name: String {
        return self.genre.name
    }
}
