//
//  FilmographyModel.swift
//  QuickFlicks
//
//  Created by Brad B on 28/08/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

// MARK: - FilmographyList
struct FilmographyList: Codable {
    let cast: [Movie]?
    let id: Int?
}

// MARK: - Cast
struct Cast: Codable {
    let id: Int?
    let character, originalTitle, overview: String?
    let voteCount: Int?
    let video: Bool?
    let mediaType: MediaType?
    let posterPath, backdropPath: String?
    let popularity: Double?
    let title: String?
    let genreIDS: [Int]?
    let voteAverage: Double?
    let adult: Bool?
    let releaseDate, creditID: String?
    let episodeCount: Int?
    let originCountry: [String]?
    let originalName, name, firstAirDate: String?
    let biography: String?

    enum CodingKeys: String, CodingKey {
        case id, character
        case originalTitle = "original_title"
        case overview
        case voteCount = "vote_count"
        case video
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case popularity, title
        case genreIDS = "genre_ids"
        case voteAverage = "vote_average"
        case adult
        case releaseDate = "release_date"
        case creditID = "credit_id"
        case episodeCount = "episode_count"
        case originCountry = "origin_country"
        case originalName = "original_name"
        case name
        case firstAirDate = "first_air_date"
        case biography
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}
