//
//  SearchView.swift
//  Flicks
//
//  Created by Brad B on 29/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var searchVM = SearchViewModel()
    @State private var searchText = ""
    @State var type = 0
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                SearchBarView(searchVM: searchVM, searchView: self, text: $searchText)
                
                Picker(selection: $type, label: Text("Select")) {
                    Text("Movies").tag(0)
                    Text("TV Shows").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                .padding(5)
                
                List {
                    
                    if type == 0 {
                        
                        ForEach(searchVM.searchedMovies, id: \.uniqueID) { movie in
                            
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                
                                MovieSearchListView(movies: movie)
                                    
                                    .onAppear(perform: {
                                        if movie == self.searchVM.searchedMovies.last {
                                            self.searchVM.checkTotalMovies(movie: self.searchText)
                                            
                                        }
                                    })
                            }
                        }
                    } else {
                        
                        ForEach(searchVM.searchedShows, id: \.uniqueID) { show in
                            
                            NavigationLink(destination: TVShowDetailView(show: show)) {
                                
                                TVSearchListView(show: show)
                                    
                                    .onAppear(perform: {
                                        if show == self.searchVM.searchedShows.last {
                                            self.searchVM.checkTotalShows(show: self.searchText)
                                            
                                        }
                                    })
                            }
                        }
                        
                    }
                }
                .navigationBarTitle("Search")
            }
        }.accentColor(.white)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
