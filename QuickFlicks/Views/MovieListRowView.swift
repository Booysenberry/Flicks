//
//  ShortlistRowView.swift
//  QuickFlicks
//
//  Created by Brad B on 13/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct MovielistRowView: View {
    
    var movies: Movie
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        
        VStack {
            // Poster
            URLImage(url: "\(movies.posterURL)", type: "coverArt")
                .frame(width: 154, height: 228)
            
            HStack {
                // Rating
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(movies.voteAveragePercent)
   
                }
                
                HStack {
                    // Release date
                    Image(systemName: "calendar")
                    
                    Text("\(movies.releaseYear)")
                        .font(.callout)
                }
            }
        }
    }
}

struct MovielistRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovielistRowView(movies: Movie.example)
    }
}

