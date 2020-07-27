//
//  DetailView.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    @ObservedObject private var detailVM = MovieDetailViewModel()
    
    // Core data
    @Environment(\.managedObjectContext) var managedObjectContext
    
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
                        Image(systemName: "clock")
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
                VStack {
                    
                    // Synopsis
                    Text(movie.overview)
                        .font(.body)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    ScrollView(.horizontal) {
                        
                        if detailVM.fetchedMovie?.credits != nil {
                            CastView(cast: (detailVM.fetchedMovie?.credits!.cast)!)
                        }
                        
                    }.padding()
                }
            }
            Spacer()
        }.navigationBarTitle(movie.title)
        
        .navigationBarItems(trailing:
                                Button(action: {
                                    
                                    // Save to core data
                                    let movieToBeSaved = SavedMovie(context: self.managedObjectContext)
                                    movieToBeSaved.title = self.movie.title
                                    movieToBeSaved.id = Int32(self.movie.id)
                                    movieToBeSaved.adult = self.movie.adult
                                    movieToBeSaved.backdropPath = self.movie.backdropPath
                                    movieToBeSaved.video = self.movie.video
                                    movieToBeSaved.popularity = self.movie.popularity
                                    movieToBeSaved.releaseDate = self.movie.releaseDate
                                    movieToBeSaved.posterPath = self.movie.posterPath
                                    movieToBeSaved.overview = self.movie.overview
                                    movieToBeSaved.voteAverage = self.movie.voteAverage
                                    movieToBeSaved.voteCount = Int32(self.movie.voteCount)
                                    movieToBeSaved.runTime = Int32(self.movie.runTime ?? 0)
                                    movieToBeSaved.isSaved = true
                                    
                                    do {
                                        try self.managedObjectContext.save()
                                    } catch {
                                        // handle the Core Data error
                                    }
                                }) {
                                    if movie.isSaved {
                                        Image(systemName: "heart.fill")
                                            .renderingMode(.original)
                                    } else {
                                        Image(systemName: "heart")
                                            .renderingMode(.original)
                                    }
                                })
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.example)
    }
}




