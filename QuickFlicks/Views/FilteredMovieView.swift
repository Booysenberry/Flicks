//
//  FilteredMovieView.swift
//  QuickFlicks
//
//  Created by Brad B on 16/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct FilteredMovieView: View {
    
    @ObservedObject private var filteredMovieVM = FilteredMovieViewModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var filter = 0
    @State private var filterString = "popularity"
    
    init() {
        filteredMovieVM.fetchMovies(filter: filterString)
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Picker(selection: $filter, label: Text("Select")) {
                    Text("Popular").tag(0)
                    Text("Top Rated").tag(1)
                }
                
                .onReceive([self.filter].publisher.first()) { (value) in
                    switch filter {
                    case 0:
                        filterString = "popularity"
                    case 1:
                        filterString = "vote_average"
                    default:
                        filterString = "popularity"
                    }
                    print(filterString)
                }.pickerStyle(SegmentedPickerStyle())
                
                
                
                ScrollView {
                    
                    LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                        
                        ForEach(filteredMovieVM.movies, id:\.id) { movie in
                            
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                
                                MovielistRowView(movies: movie)
                            }.buttonStyle(PlainButtonStyle())
                            
                            .onAppear(perform: {
                                if movie == self.filteredMovieVM.movies.last {
                                    
                                    switch filter {
                                    case 0:
                                        self.filteredMovieVM.checkTotalMovies(filter: "popularity")
                                    case 1:
                                        self.filteredMovieVM.checkTotalMovies(filter: "vote_average")
                                    default:
                                        self.filteredMovieVM.checkTotalMovies(filter: "popularity")
                                    }
                                }
                            })
                        }
                    }
                }
                .navigationBarTitle("Popular Movies")
            }
        }
    }
}


struct FilteredMovieView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredMovieView()
    }
}
