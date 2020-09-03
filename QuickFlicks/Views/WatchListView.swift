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
    
    @StateObject var watchListVM = WatchListViewModel()
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var type = 0
    
    // Create core data movie fetch request
    @FetchRequest(
        entity: SavedMovie.entity(),
        sortDescriptors: []
    ) var savedMovies: FetchedResults<SavedMovie>
    
    // Create core data show fetch request
    @FetchRequest(
        entity: SavedShow.entity(),
        sortDescriptors: []
    ) var savedShows: FetchedResults<SavedShow>
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Picker(selection: $type, label: Text("Select")) {
                    Text("Movies").tag(0)
                    Text("TV Shows").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                
                List {
                    
                    if type == 0 {
                        
                        ForEach(watchListVM.watchListMovies, id: \.id) { movie in
                            
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                
                                MovieSearchListView(movies: movie)
                                
                            }
                        }.onDelete(perform: removeMovie)
                    } else {
                        
                        ForEach(watchListVM.watchListTVShows, id: \.id) { show in
                            
                            NavigationLink(destination: TVShowDetailView(show: show)) {
                                
                                TVSearchListView(show: show)
                            }
                        }.onDelete(perform: removeShow)
                    }
                }
            }
            .navigationBarTitle("Watch List")
            .navigationBarItems(trailing: EditButton())
        }
        .onAppear {
            self.watchListVM.watchListMovies.removeAll()
            self.watchListVM.moviesToAnyObject(movies: self.savedMovies)
            self.watchListVM.watchListTVShows.removeAll()
            self.watchListVM.showToAnyObject(shows: self.savedShows)
        }.accentColor(.white)
    }
    
    // Delete movie from core data
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
        self.watchListVM.moviesToAnyObject(movies: self.savedMovies)
    }
    
    // Delete show from core data
    func removeShow(at offsets: IndexSet) {
        for index in offsets {
            let show = savedShows[index]
            managedObjectContext.delete(show)
        }
        do {
            try managedObjectContext.save()
            
        } catch {
            // handle the Core Data error
        }
        self.watchListVM.watchListTVShows.removeAll()
        self.watchListVM.showToAnyObject(shows: self.savedShows)
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
