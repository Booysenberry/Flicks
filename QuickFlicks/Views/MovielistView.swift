//
//  ShortlistView.swift
//  QuickFlicks
//
//  Created by Brad B on 10/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct MovielistView: View {
    
    @ObservedObject private var movielistVM = MovieListViewModel()
    
    var genre: GenreElement
    
    var body: some View {
        
        List {
            
            ForEach(movielistVM.fetchedMovies, id: \.id) { movie in
                
                NavigationLink(destination: MovieDetailView(movie: MoviesViewModel(movie: movie))) {
                    
                    MovielistRowView(movies: MoviesViewModel(movie: movie))
                }
            }
            
        }.onAppear {
            self.movielistVM.fetchMovies(genre: self.genre.id)
            
        }
        .navigationBarTitle(genre.name)
    }
}

struct ShortlistView_Previews: PreviewProvider {
    static var previews: some View {
        MovielistView(genre: GenreElement(id: 1, name: "Action"))
    }
}
