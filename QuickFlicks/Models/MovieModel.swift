//
//  MovieModel.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

// MARK: - MovieList
struct MovieList: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let movie: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movie = "results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String?
    let id: Int
    let adult: Bool
    let backdropPath: String
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    #if DEBUG
    static let example = Movie(popularity: 5, voteCount: 10, video: false, posterPath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg", id: 157336, adult: false, backdropPath: "/9mmkq59uRuJWDFz9UHeX5ATNJYf.jpg", title: "Interstellar", voteAverage: 7, overview: "Interstellar chronicles the adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.", releaseDate: "2014-11-05")
    #endif
}
