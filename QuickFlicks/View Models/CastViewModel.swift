//
//  CastViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 6/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class CastViewModel {
    
    var id = UUID()

    var cast: Credits


    init(cast: Credits) {
        self.cast = cast
    }

    var name: String {
        return cast.cast.first?.name ?? ""
    }

    var profileURL: URL {
        
        return URL(string: "https://image.tmdb.org/t/p/w500\(cast.cast.first?.profilePath ?? "")")!
    }
    
}
