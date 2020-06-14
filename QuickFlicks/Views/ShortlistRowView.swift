//
//  ShortlistRowView.swift
//  QuickFlicks
//
//  Created by Brad B on 13/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct ShortlistRowView: View {
    
    var movie: Result
    
    var body: some View {
        
        HStack {
            
//            URLImage(url: "https://image.tmdb.org/t/p/w185/\(movie.posterPath!)")
            Text("\(movie.title!)")
            
        }
    }
}

struct ShortlistRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ShortlistRowView(movie: Result(popularity: 6, voteCount: 100, video: false, posterPath: "/aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg", id: 454626, adult: false, backdropPath: "/stmYfCUGd8Iy6kAMBr6AmWqx8Bq.jpg", originalLanguage: OriginalLanguage(rawValue: "en")!, originalTitle: "Sonic the Hedgehog", genreIDS: [28,35,878,10751], title: "Sonic the Hedgehog", voteAverage: 6.7, overview: "Based on the global blockbuster videogame franchise from Sega, Sonic the Hedgehog tells the story of the world’s speediest hedgehog as he embraces his new home on Earth. In this live-action adventure comedy, Sonic and his new best friend team up to defend the planet from the evil genius Dr. Robotnik and his plans for world domination.", releaseDate: "2020-02-12"))
    }
}

