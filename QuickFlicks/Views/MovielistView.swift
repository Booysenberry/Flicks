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
    @ObservedObject private var pickerModel = PickerModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var genre: GenreElement
    
    init(genre: GenreElement) {
        self.genre = genre
    }
    
    var body: some View {
        
        VStack {
            
            Picker(selection: $pickerModel.filter, label: Text("Select")) {
                ForEach(0 ..< pickerModel.pickerOptions.count) {
                           Text(pickerModel.pickerOptions[$0])
                        }
                     }.onReceive(pickerModel.$filter) { (value) in
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
                            
                            MovielistRowView(movies: movie)
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                        .onAppear(perform: {
                            if movie == self.movielistVM.movies.last {
                                switch pickerModel.filter {
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
