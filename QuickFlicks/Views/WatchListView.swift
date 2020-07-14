//
//  WatchListView.swift
//  QuickFlicks
//
//  Created by Brad B on 8/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI
import CoreData

struct WatchListView: View {
    
    @ObservedObject var watchListVM = WatchListViewModel()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Create core data fetch request
    @FetchRequest(
        entity: SavedMovie.entity(),
        sortDescriptors: []
    ) var savedMovies: FetchedResults<SavedMovie>
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(watchListVM.watchListMovies, id: \.id) { movie in
                    
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        
                        MovielistRowView(movies: movie)
                        
                    }
                }.onDelete(perform: removeMovie) // Swipe to delete
                
            }
            .onAppear(perform: {
                self.watchListVM.watchListMovies.removeAll()
                self.watchListVM.toAnyObject(movies: self.savedMovies)
            })
                .navigationBarTitle("Watch List")
            //              .navigationBarItems(trailing: EditButton())
            
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
        self.watchListVM.watchListMovies.removeAll()
        self.watchListVM.toAnyObject(movies: self.savedMovies)
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
