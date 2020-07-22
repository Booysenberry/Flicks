//
//  TVShowModel.swift
//  QuickFlicks
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
    let originalName: String
    let genreIDS: [Int]
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
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name, popularity
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}

// MARK: - ShowCast
struct ShowCast: Codable {
    let cast: [Cast]
    let id: Int
}

extension Show {
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id
    }
}
