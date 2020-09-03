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
    
    @State var filter = 0
    private let pickerOptions = ["Popular", "Top Rated"]
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var genre: GenreElement
    
    init(genre: GenreElement) {
        self.genre = genre
        movielistVM.fetchMovies(genre: genre.id, filter: "popularity")
    }
    
    var body: some View {
        
        VStack {
            
            Picker(selection: $filter, label: Text("Select")) {
                Text("Popular").tag(0)
                Text("Top Rated").tag(1)
            }
            .onChange(of: filter) { value in
                
                switch value {
                case 0:
                    movielistVM.movies.removeAll()
                    movielistVM.currentPage = 1
                    movielistVM.fetchMovies(genre: genre.id, filter: "popularity")
                case 1:
                    movielistVM.movies.removeAll()
                    movielistVM.currentPage = 1
                    movielistVM.fetchMovies(genre: genre.id, filter: "vote_average")
                default:
                    movielistVM.movies.removeAll()
                    movielistVM.currentPage = 1
                    movielistVM.fetchMovies(genre: genre.id, filter: "popularity")
                }
                
            }.pickerStyle(SegmentedPickerStyle())
            
            ScrollView {
                
                LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                    
                    ForEach(movielistVM.movies, id:\.id) { movie in
                        
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            
                            MovieGridItemView(movies: movie)
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                        .onAppear(perform: {
                            if movie == self.movielistVM.movies.last {
                                switch filter {
                                case 0:
                                    self.movielistVM.checkTotalMovies(genre: self.genre.id, filter: "popularity")
                                case 1:
                                    self.movielistVM.checkTotalMovies(genre: self.genre.id, filter: "vote_average")
                                default:
                                    self.movielistVM.checkTotalMovies(genre: self.genre.id, filter: "popularity")
                                }
                                
                            }
                        })
                    }
                }.navigationBarTitle(genre.name)
            }
        }
    }
}

struct ShortlistView_Previews: PreviewProvider {
    static var previews: some View {
        MovielistView(genre: GenreElement(id: 1, name: "Action"))
    }
}
