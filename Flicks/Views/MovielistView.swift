//
//  ShortlistView.swift
//  Flicks
//
//  Created by Brad B on 10/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct MovielistView: View {
    
    @ObservedObject private var movielistVM = MovieListViewModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var genre: GenreElement
    
    init(genre: GenreElement) {
        self.genre = genre
        movielistVM.fetchMovies(genre: genre.id, filter: "popularity")
    }
    
    var body: some View {
        
        VStack {
            
            if movielistVM.movies.isEmpty {
                
                Spacer()
                
                VStack {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .padding()
                    
                    Text("Connecting...").padding(5)
                }
                Spacer()
            } else {
                
                ScrollView {
                    
                    LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                        
                        ForEach(movielistVM.movies, id:\.id) { movie in
                            
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                
                                MovieGridItemView(movies: movie)
                                
                            }.buttonStyle(PlainButtonStyle())
                            
                            .onAppear(perform: {
                                if movie == self.movielistVM.movies.last {
                                    switch movielistVM.filter {
                                    case "popularity":
                                        self.movielistVM.checkTotalMovies(genre: self.genre.id, filter: "popularity")
                                    case "vote_average":
                                        self.movielistVM.checkTotalMovies(genre: self.genre.id, filter: "vote_average")
                                    case "primary_release_date":
                                        self.movielistVM.checkTotalMovies(genre: self.genre.id, filter: "primary_release_date")
                                    case "revenue":
                                        self.movielistVM.checkTotalMovies(genre: self.genre.id, filter: "revenue")
                                    default:
                                        self.movielistVM.checkTotalMovies(genre: self.genre.id, filter: "popularity")
                                    }
                                    
                                }
                            })
                        }
                    }
                }
                
                BannerAdView()
                    
                    .navigationBarItems(trailing:
                                            Menu {
                                                Button(action: movielistVM.topRated, label: {
                                                    Text("Top Rated")
                                                    Image(systemName: "star.fill")
                                                    
                                                })
                                                
                                                Button(action: movielistVM.popular, label: {
                                                    Text("Trending")
                                                    Image(systemName: "flame.fill")
                                                    
                                                })
                                                
                                                Button(action: movielistVM.releaseDate, label: {
                                                    Text("Newest")
                                                    Image(systemName: "calendar")
                                                    
                                                })
                                                
                                                Button(action: movielistVM.highestGrossing, label: {
                                                    Text("Revenue")
                                                    Image(systemName: "dollarsign.square.fill")
                                                    
                                                })
                                                
                                            } label: {
                                                Label(
                                                    title: { Text("\(movielistVM.label)") },
                                                    icon: { Image(systemName: movielistVM.icon) }
                                                ).frame(width: 120)
                                            })
            }
        }.padding(5)
        .navigationBarTitle(genre.name)
    }
}

struct ShortlistView_Previews: PreviewProvider {
    static var previews: some View {
        MovielistView(genre: GenreElement(id: 1, name: "Action"))
    }
}
