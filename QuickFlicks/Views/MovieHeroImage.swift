//
//  MovieHeroImage.swift
//  QuickFlicks
//
//  Created by Brad B on 1/09/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct MovieHeroImage: View {
    
    var movie: Movie
    var runTime: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Cover picture
            
            URLImage(url: "https://image.tmdb.org/t/p/w500\(movie.backdropPath ?? "")", type: "movie")
                .aspectRatio(contentMode: .fit)
            
            HStack {
                
                // Rating avg
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(movie.voteAveragePercent)
                    
                }
                Spacer()
                
                // Rating count
                HStack {
                    Image(systemName: "person.3")
                    
                    Text("\(movie.voteCount)")
                    
                }
                Spacer()
                
                // Movie runtime
                HStack {
                    Image(systemName: "clock")
                    
                    Text("\(runTime)")
                }
            }
            .padding()
            .background(Color.black.opacity(0.5))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            
        }
    }
}

struct MovieHeroImage_Previews: PreviewProvider {
    static var previews: some View {
        MovieHeroImage(movie: Movie.example)
    }
}
