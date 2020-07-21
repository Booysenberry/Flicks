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
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var genre: GenreElement
    
    init(genre: GenreElement) {
        self.genre = genre
        movielistVM.fetchMovies(genre: genre.id)
    }
    
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                
                ForEach(movielistVM.movies, id:\.id) { movie in
                    
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        
                        MovielistRowView(movies: movie)
                        
                    }.buttonStyle(PlainButtonStyle())
                    
                    .onAppear(perform: {
                        if movie == self.movielistVM.movies.last {
                            self.movielistVM.checkTotalMovies(genre: self.genre.id)
                        }
                    })
                }
            }.navigationBarTitle(genre.name)
        }
    }
}

struct ShortlistView_Previews: PreviewProvider {
    static var previews: some View {
        MovielistView(genre: GenreElement(id: 1, name: "Action"))
    }
}
