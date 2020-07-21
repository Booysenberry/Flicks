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
    
    var filter: String = "popularity"
    
    var body: some View {
        
        
        NavigationView {
            
            ScrollView {
                
                LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                    
                    ForEach(filteredMovieVM.movies, id:\.id) { movie in
                        
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            
                            MovielistRowView(movies: movie)
                        }.buttonStyle(PlainButtonStyle())
                        
                        .onAppear(perform: {
                            if movie == self.filteredMovieVM.movies.last {
                                self.filteredMovieVM.checkTotalMovies(filter: filter)
                            }
                        })
                    }
                }
            }.navigationBarTitle("Popular Movies")
        }
    }
}

//struct FilteredMovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredMovieView(filteredMovies: [Movie)])
//    }
//}
