//
//  MovieModel.swift
//  Flicks
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
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

// MARK: - Result
struct Movie: Codable, Equatable {
    let popularity: Double
    let voteCount: Int
    let posterPath: String?
    let id: Int
    let backdropPath: String?
    let title: String?
    let genres: [GenreElement]?
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    let runTime: Int?
    let credits: Credits?
    var uniqueID = UUID()
    var watchProvider: WatchProviders?
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
    
    var voteAveragePercent: String {
        return "\(Int(voteAverage * 10))%"
    }
    
    var releaseYear: String {
        let dateComponents = releaseDate?.components(separatedBy: "-")
        return dateComponents?[0] ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case runTime = "runtime"
        case credits
        case genres
        
    }
    
    #if DEBUG
    static let example = Movie(popularity: 5, voteCount: 10, posterPath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg", id: 157336, backdropPath: "/9mmkq59uRuJWDFz9UHeX5ATNJYf.jpg", title: "InterstellarInterstellarInterstellar", genres: [GenreElement(id: 1, name: "Action")], voteAverage: 7, overview: "Interstellar chronicles the adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.", releaseDate: "2014-11-05", runTime: 120, credits: Credits(cast: [Actors(id: 1, name: "Edward Norton", profilePath: "/eIkFHNlfretLS1spAcIoihKUS62.jpg")]))
    #endif
}


// MARK: - Credits
struct Credits: Codable {
    let cast: [Actors]
}

// MARK: - Cast
struct Actors: Codable {
    let id: Int?
    let name: String?
    let profilePath: String?
    
    
    var profileURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(profilePath ?? "")")!
    }

    enum CodingKeys: String, CodingKey {

        case id
        case name
        case profilePath = "profile_path"
    }
    
    #if DEBUG
    static let example = Actors(id: 63, name: "Bob Stone", profilePath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
    #endif
}

// MARK: - RecommendedMovies
struct RecommendedMovies: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - WatchProviders
struct WatchProviders: Codable {
    let id: Int?
    let results: Results?
}

// MARK: - Results
struct Results: Codable {
    let ar, at, au, be: Ar?
    let br, ca, ch, cl: Ar?
    let co, cz, de, dk: Ar?
    let ec, ee, es, fi: Ar?
    let fr, gb, gr, hu: Ar?
    let id, ie, resultsIN, it: Ar?
    let jp, kr, lt, lv: Ar?
    let mx, my, nl, no: Ar?
    let nz, pe, ph, pl: Ar?
    let pt: Ar?
    let ro: Ro?
    let ru, se, sg, th: Ar?
    let tr, us, ve, za: Ar?

    enum CodingKeys: String, CodingKey {
        case ar = "AR"
        case at = "AT"
        case au = "AU"
        case be = "BE"
        case br = "BR"
        case ca = "CA"
        case ch = "CH"
        case cl = "CL"
        case co = "CO"
        case cz = "CZ"
        case de = "DE"
        case dk = "DK"
        case ec = "EC"
        case ee = "EE"
        case es = "ES"
        case fi = "FI"
        case fr = "FR"
        case gb = "GB"
        case gr = "GR"
        case hu = "HU"
        case id = "ID"
        case ie = "IE"
        case resultsIN = "IN"
        case it = "IT"
        case jp = "JP"
        case kr = "KR"
        case lt = "LT"
        case lv = "LV"
        case mx = "MX"
        case my = "MY"
        case nl = "NL"
        case no = "NO"
        case nz = "NZ"
        case pe = "PE"
        case ph = "PH"
        case pl = "PL"
        case pt = "PT"
        case ro = "RO"
        case ru = "RU"
        case se = "SE"
        case sg = "SG"
        case th = "TH"
        case tr = "TR"
        case us = "US"
        case ve = "VE"
        case za = "ZA"
    }
}

// MARK: - Ar
struct Ar: Codable {
    let link: String?
    let flatrate, rent, buy: [Buy]?
}

// MARK: - Buy
struct Buy: Codable {
    let displayPriority: Int?
    let logoPath: String?
    let providerID: Int?
    let providerName: String?

    enum CodingKeys: String, CodingKey {
        case displayPriority = "display_priority"
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
    }
}

// MARK: - Ro
struct Ro: Codable {
    let link: String?
    let flatrate: [Buy]?
}


extension Movie {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}

