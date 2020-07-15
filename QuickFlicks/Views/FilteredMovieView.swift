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
    
    var filter: String = "popularity"
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(filteredMovieVM.movies, id: \.id) { movie in
                    
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        
                        MovielistRowView(movies: movie)
                        
                        .onAppear(perform: {
                            if movie == self.filteredMovieVM.movies.last {
                                self.filteredMovieVM.checkTotalMovies(filter: self.filter)
                            }
                        })
                    }
                }.navigationBarTitle("Movies")
            }
        }
    }
}


//struct FilteredMovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredMovieView(filteredMovies: [Movie)])
//    }
//}
