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
        
        // Stop Scrollview bounce
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
        VStack {
            
            MovieHeroImage(movie: movie)
            
            HStack {
                
                ForEach(((detailVM.fetchedMovie?.genres)!), id:\.id) { genre in
                    
                    Text("\(genre.name)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(2)
                        .border(Color.gray)
                    
                }
                
                Spacer()
                
                // Runtime
                HStack {
                    Image(systemName: "clock")
                    Text("\(detailVM.fetchedMovie?.runTime ?? 1) mins")
                    
                }
                
            }.padding()
            
            ScrollView {
                VStack {
                    
                    // Synopsis
                    Text(movie.overview)
                        .font(.body)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        if detailVM.fetchedMovie?.credits != nil {
                            CastView(cast: (detailVM.fetchedMovie?.credits!.cast)!)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }.padding()
                }
            }
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
