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
            URLImage(url: "\(show.posterURL)", type: "cast")
                .frame(width: 92, height: 136)
            
            
            VStack(alignment: .leading) {
                
                // Title
                Text(show.name)
                    .font(.body).bold()
                    .lineLimit(nil)
                    .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                
                // Rating
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(show.voteAveragePercent)
                }.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                Spacer()
            }
        }
    }
}

struct TVSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        TVSearchListView(show: Show.example)
    }
}
