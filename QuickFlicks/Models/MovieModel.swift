//
//  MovieModel.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    var posterURL: String
    var title: String
    var rating: Double
    var ratingCount: Double
    var releaseDate: String
    var overview: String
    
    enum CodingKeys: String, CodingKey {
       
        case posterURL = "poster_path"
        case rating = "vote_average"
        case ratingCount = "vote_count"
        case releaseDate = "release_date"
        case title
        case overview
        
    }
    
    #if DEBUG
    static let example = Movie(posterURL: "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg", title: "Ad Astra", rating: 6, ratingCount: 99, releaseDate: "2019-09-17", overview: "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.")
    #endif
    
}
