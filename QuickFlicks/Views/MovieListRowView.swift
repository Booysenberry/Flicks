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
    
    var body: some View {
        
        HStack {
            
            URLImage(url: "\(movies.posterURL)")
                .frame(width: 92, height: 136)
            
            VStack(alignment: .leading) {
                
                Text(movies.title)
                    .font(.headline)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Text(movies.voteAveragePercent)
                            .font(.callout)
                        
                    }
                }
                Spacer()
            }
            
        }
    }
}

struct MovielistRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovielistRowView(movies: Movie.example)
    }
}

