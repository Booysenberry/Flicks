//
//  WatchListView.swift
//  QuickFlicks
//
//  Created by Brad B on 8/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct WatchListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Create core data fetch request
    @FetchRequest(
        entity: SavedMovie.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \SavedMovie.title, ascending: true)
        ]
    ) var savedMovies: FetchedResults<SavedMovie>
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(savedMovies, id: \.self) { movie in
                    
                    NavigationLink(destination: MovieDetailView(movie: Movie(popularity: movie.popularity, voteCount: Int(movie.voteCount), video: movie.video, posterPath: movie.posterPath, id: Int(movie.id), adult: movie.adult, backdropPath: movie.backdropPath, title: movie.title ?? "", voteAverage: movie.voteAverage, overview: movie.overview ?? "", releaseDate: movie.releaseDate, runTime: Int(movie.runTime), credits: nil))) {
                        
                        
                        MovielistRowView(movies: Movie.example)
                        
                    }
                }.onDelete(perform: removeMovie) // Swipe to delete
            }
            .navigationBarTitle("Watch List")
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    // Delete from core data
    func removeMovie(at offsets: IndexSet) {
        for index in offsets {
            let movie = savedMovies[index]
            managedObjectContext.delete(movie)
        }
        do {
            try managedObjectContext.save()
        } catch {
            // handle the Core Data error
        }
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
