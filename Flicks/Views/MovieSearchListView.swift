//
//  SearchListView.swift
//  Flicks
//
//  Created by Brad B on 21/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct MovieSearchListView: View {
    
    var movies: Movie
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        
        HStack {
            
            // Poster
            URLImage(url: "\(movies.posterURL)", type: "coverArt")
                .frame(width: 92, height: 136)
            
            
            VStack(alignment: .leading) {
                
                // Title
                Text(movies.title ?? "")
                    .font(.body).bold()
                    .lineLimit(nil)
                    .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                
                // Rating
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(movies.voteAveragePercent)
                }.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                
                // Release date
                HStack {
                    Image(systemName: "calendar")
                    
                    Text("\(movies.releaseYear)")
                        .font(.callout)
                }
                Spacer()
            }
        }
    }
}

//struct SearchListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieSearchListView(movies: Movie.example)
//    }
//}
