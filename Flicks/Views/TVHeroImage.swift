//
//  TVHeroImage.swift
//  Flicks
//
//  Created by Brad B on 1/09/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct TVHeroImage: View {
    
    var show: Show
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Cover art
            URLImage(url: "\(show.backdropURL)", type: "coverArt")
                .aspectRatio(contentMode: .fit)
            
            HStack {
                
                
                // Rating avg
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(show.voteAveragePercent)
                    
                }
                Spacer()
                
                // Rating count
                HStack {
                    Image(systemName: "person.3")
                    
                    Text("\(show.voteCount)")
                    
                }
            }
            .padding()
            .background(Color.black.opacity(0.5))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
        }
    }
}

struct TVHeroImage_Previews: PreviewProvider {
    static var previews: some View {
        TVHeroImage(show: Show.example)
    }
}
