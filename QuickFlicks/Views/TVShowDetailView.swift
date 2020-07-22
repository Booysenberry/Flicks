//
//  TVShowDetailView.swift
//  QuickFlicks
//
//  Created by Brad B on 22/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct TVShowDetailView: View {
    
    @ObservedObject private var TVDetailVM = TVDetailViewModel()
    
    var show: Show
    
    init(show: Show) {
        self.show = show
        TVDetailVM.getCast(show: show.id)
        
    }
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .bottom) {
                
                // Cover picture
                
                URLImage(url: "\(show.backdropURL)")
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
        
        ScrollView {
            
            // Synopsis
            Text(show.overview)
                .font(.body)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
            
            ScrollView(.horizontal) {
                
                if TVDetailVM.castMembers != nil {
                    CastView(cast: TVDetailVM.castMembers)
                }
                
            }.padding()
            
        }.navigationBarTitle(show.name)
    }
}


//struct TVShowDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowDetailView()
//    }
//}
