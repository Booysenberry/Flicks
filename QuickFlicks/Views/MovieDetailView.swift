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
    
    @State private var showingAlert = false
    
    init(movie: Movie) {
        self.movie = movie
        detailVM.getMovieDetails(id: movie.id)
        detailVM.getRecommendedMovies(movie: movie.id)
        
        // Stop Scrollview bounce
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
        VStack {
            
            // Movie poster
            MovieHeroImage(movie: movie)
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    Section {
                    
                    // Synopsis
                    Text(movie.overview)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer(minLength: 40)
                    
                    Section(header: Text("Cast").font(.title2)) {
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            // Cast members
                            if detailVM.fetchedMovie?.credits != nil {
                                HStack {
                                    CastView(cast: (detailVM.fetchedMovie?.credits!.cast)!)
                                        .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                    Spacer(minLength: 40)
                    
                    Section(header: Text("Recommended Movies").font(.title2)) {
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            // Recommended movies
                            HStack(spacing: 20) {
                                ForEach(detailVM.recommendedMovies, id:\.uniqueID) { movie in
                                    
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        
                                        MovieGridItemView(movies: movie)
                                        
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
            }.padding()
            Spacer()
        }
        
        .navigationBarTitle(movie.title ?? "")
        
        .navigationBarItems(trailing:
                                Button(action: {
                                    
                                    // Save to core data
                                    let movieToBeSaved = SavedMovie(context: self.managedObjectContext)
                                    movieToBeSaved.title = self.movie.title
                                    movieToBeSaved.id = Int32(self.movie.id)
                                    movieToBeSaved.backdropPath = self.movie.backdropPath
                                    movieToBeSaved.popularity = self.movie.popularity
                                    movieToBeSaved.releaseDate = self.movie.releaseDate
                                    movieToBeSaved.posterPath = self.movie.posterPath
                                    movieToBeSaved.overview = self.movie.overview
                                    movieToBeSaved.voteAverage = self.movie.voteAverage
                                    movieToBeSaved.voteCount = Int32(self.movie.voteCount)
                                    movieToBeSaved.runTime = Int32(self.movie.runTime ?? 0)
                                    
                                    self.showingAlert = true
                                    
                                    do {
                                        try self.managedObjectContext.save()
                                    } catch {
                                        // handle the Core Data error
                                    }
                                }) {
                                    Image(systemName: "plus")
                                        .renderingMode(.original)
                                }.alert(isPresented: $showingAlert) {
                                    Alert(title: Text("Saved"), message: Text("Movie added to your watch list"), dismissButton: .default(Text("Ok")))
                                })
        
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.example)
    }
}
