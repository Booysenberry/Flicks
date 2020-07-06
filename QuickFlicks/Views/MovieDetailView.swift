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
    
    init(movie: Movie) {
        self.movie = movie
        detailVM.getMovieDetails(id: movie.id)
        
    }
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .bottom) {
                
                // Cover picture
                
                URLImage(url: "https://image.tmdb.org/t/p/w500\(detailVM.fetchedMovie?.backdropPath ?? "")")
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    
                    // Runtime
                    HStack {
                        Image(systemName: "timer")
                        Text("\(detailVM.fetchedMovie?.runTime ?? 1) mins")
                        
                    }
                    Spacer()
                    
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
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
            }
            
            ScrollView {
                
                // Synopsis
                Text(movie.overview)
                    
                    .font(.body)
                    .padding()
                
                // Cast
                ScrollView(.horizontal) {
                    
                    HStack {
                        CastView(cast: (detailVM.fetchedMovie?.credits!.cast)!)
                    }.padding()
                }
            }
            Spacer()
        }.navigationBarTitle(movie.title)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.example)
    }
}




