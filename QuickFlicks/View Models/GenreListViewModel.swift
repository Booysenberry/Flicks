//
//  GenreViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class GenreListViewModel: ObservableObject {
    
    @Published var fetchedGenres = [GenreElement]()
    
    init() {
        fetchGenres()
    }
    
    func fetchGenres() {
        
        WebService().getGenres { genres in
            
            if let genre = genres?.genres {
                
                self.fetchedGenres.append(contentsOf: genre)
        
            }
        }
    }
}
