//
//  TVSearchListView.swift
//  QuickFlicks
//
//  Created by Brad B on 27/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct TVSearchListView: View {
    
    var show: Show
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        
        HStack {
            
            // Poster
            URLImage(url: "\(show.posterURL)")
                .frame(width: 92, height: 136)
            
            
            VStack(alignment: .leading) {
                
                // Title
                Text(show.name)
                    .font(.body)
                    .lineLimit(nil)
                
                // Rating
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(show.voteAveragePercent)
                }
            }
        }
    }
}

//struct TVSearchListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TVSearchListView()
//    }
//}