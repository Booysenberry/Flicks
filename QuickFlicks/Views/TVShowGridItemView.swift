//
//  TVShowRowView.swift
//  QuickFlicks
//
//  Created by Brad B on 22/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct TVShowGridItemView: View {
    
    var shows: Show
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        
        VStack {
            // Poster
            URLImage(url: "\(shows.posterURL)", type: "coverArt")
                .frame(width: 154, height: 228)
            

                // Rating
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(shows.voteAveragePercent)
                    
                }
            }
        }
    }

struct TVShowGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowGridItemView(shows: Show.example)
    }
}
