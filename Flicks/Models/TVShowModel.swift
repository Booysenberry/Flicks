//
//  TVShowModel.swift
//  Flicks
//
//  Created by Brad B on 22/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

// MARK: - TVShow
struct TVShowList: Codable {
    let page, totalResults, totalPages: Int
    let shows: [Show]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case shows = "results"
    }
}

// MARK: - Result
struct Show: Codable, Equatable {
    let name: String
    let popularity: Double
    let voteCount: Int
    let backdropPath: String?
    let id: Int
    let voteAverage: Double
    let overview: String
    let posterPath: String?
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var voteAveragePercent: String {
        return "\(Int(voteAverage * 10))%"
    }

    enum CodingKeys: String, CodingKey {
        case name, popularity
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
    
    #if DEBUG
    static let example = Show(name: "Interstellar", popularity: 9.0, voteCount: 100, backdropPath: "/9mmkq59uRuJWDFz9UHeX5ATNJYf.jpg", id: 99, voteAverage: 9.0, overview: "Interstellar chronicles the adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.", posterPath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
    #endif
}

// MARK: - ShowCast
struct ShowCast: Codable {
    let cast: [Actors]
    let id: Int
}

extension Show {
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id
    }
}
