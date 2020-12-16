//
//  FilteredMovieView.swift
//  Flicks
//
//  Created by Brad B on 16/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct FilteredMoviesGridView: View {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        appearance.backgroundColor = .systemRed
    }
    
    @ObservedObject private var filteredMovieVM = FilteredMovieGridViewModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if filteredMovieVM.movies.isEmpty {
                    
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
                            
                            ForEach(filteredMovieVM.movies, id:\.uniqueID) { movie in
                                
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    
                                    MovieGridItemView(movies: movie)
                                    
                                    
                                }.buttonStyle(PlainButtonStyle())
                                
                                .onAppear(perform: {
                                    if movie == self.filteredMovieVM.movies.last {
                                        
                                        switch filteredMovieVM.filter {
                                        case "popularity":
                                            self.filteredMovieVM.checkTotalMovies(filter: "popularity")
                                        case "vote_average":
                                            self.filteredMovieVM.checkTotalMovies(filter: "vote_average")
                                        case "primary_release_date":
                                            self.filteredMovieVM.checkTotalMovies(filter: "primary_release_date")
                                        case "revenue":
                                            self.filteredMovieVM.checkTotalMovies(filter: "revenue")
                                        default:
                                            self.filteredMovieVM.checkTotalMovies(filter: "popularity")
                                        }
                                    }
                                })
                            }
                        }
                    }
                    BannerAdView()
                }
            }
            
            .padding(.top, 5)
            
            .navigationBarItems(trailing:
                                    Menu {
                                        Button(action: filteredMovieVM.topRated, label: {
                                            Text("Top Rated")
                                            Image(systemName: "star.fill")
                                            
                                        })
                                        
                                        Button(action: filteredMovieVM.popular, label: {
                                            Text("Trending")
                                            Image(systemName: "flame.fill")
                                            
                                        })
                                        
                                        Button(action: filteredMovieVM.releaseDate, label: {
                                            Text("Newest")
                                            Image(systemName: "calendar")
                                            
                                        })
                                        
                                        Button(action: filteredMovieVM.highestGrossing, label: {
                                            Text("Revenue")
                                            Image(systemName: "dollarsign.square.fill")
                                            
                                        })
                                        
                                    } label: {
                                        Label(
                                            title: { Text("\(filteredMovieVM.label)") },
                                            icon: { Image(systemName: filteredMovieVM.icon) }
                                        ).frame(width: 120)
                                    }
            )
            .navigationBarTitle("Movies", displayMode: .automatic)
        }.accentColor(.white)
    }
}


struct FilteredMoviesGridView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredMoviesGridView()
    }
}
