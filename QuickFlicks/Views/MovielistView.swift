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
    
    init(genre: GenreElement) {
        self.genre = genre
        movielistVM.fetchMovies(genre: genre.id)
        
    }
    
    var body: some View {
        
        List {
            
            ForEach(movielistVM.movies, id: \.id) { movie in
                
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    
                    MovielistRowView(movies: movie)
                        
                    .onAppear(perform: {
                        if movie == self.movielistVM.movies.last {
                            self.movielistVM.checkTotalMovies(genre: self.genre.id)
                        }
                    })
                }
            }
            
        }.navigationBarTitle(genre.name)
        .navigationBarItems(trailing:
        Button(action: {
          print("button pressed")

        }) {
            Image(systemName: "gift")
            .renderingMode(.original)
        })
    }
}

struct ShortlistView_Previews: PreviewProvider {
    static var previews: some View {
        MovielistView(genre: GenreElement(id: 1, name: "Action"))
    }
}
