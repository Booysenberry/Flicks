//
//  GenreModel.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

// MARK: - Genre
struct Genre: Codable, Identifiable {
    let id = UUID()
    let genres: [GenreElement]
}

// MARK: - GenreElement
struct GenreElement: Codable {
    let id: Int
    let name: String

}
