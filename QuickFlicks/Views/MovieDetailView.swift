//
//  DetailView.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    @ObservedObject private var detailVM = DetailViewModel()
    
    var movie: Movie
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .bottom) {
                
                URLImage(url: "\(movie.backdropURL)")
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    
                    HStack {
                        Image(systemName: "timer")
                        Text("\(detailVM.fetchedMovie?.runTime ?? 1) mins")
                        
                    }
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Text(movie.voteAveragePercent)
                        
                    }
                    Spacer()
                    
                    HStack {
                        Image(systemName: "person.3")
                        
                        Text("\(movie.voteCount)")
                        
                    }
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)

            }
            
            
            Text(movie.overview)
                .padding()
            
            Spacer()
            
        }.onAppear {
            self.detailVM.getMovieDetails(id: self.movie.id)
        }
        .navigationBarTitle(movie.title)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.example)
    }
}




