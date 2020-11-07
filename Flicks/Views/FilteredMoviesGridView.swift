//
//  FilteredMovieView.swift
//  Flicks
//
//  Created by Brad B on 16/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct FilteredMoviesGridView: View {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        appearance.backgroundColor = .systemYellow
    }
    
    @ObservedObject private var filteredMovieVM = FilteredMovieGridViewModel()
    @ObservedObject private var pickerModel = PickerModel()
    @State var filter = 0
    private let pickerOptions = ["Popular", "Top Rated"]
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Picker(selection: $filter, label: Text("Select")) {
                    Text("Popular").tag(0)
                    Text("Top Rated").tag(1)
                }
                .onChange(of: filter) { value in
                    
                    switch value {
                    case 0:
                        filteredMovieVM.movies.removeAll()
                        filteredMovieVM.currentPage = 1
                        filteredMovieVM.fetchMovies(filter: "popularity")
                    case 1:
                        filteredMovieVM.movies.removeAll()
                        filteredMovieVM.currentPage = 1
                        filteredMovieVM.fetchMovies(filter: "vote_average")
                    default:
                        filteredMovieVM.movies.removeAll()
                        filteredMovieVM.currentPage = 1
                        filteredMovieVM.fetchMovies(filter: "popularity")
                    }
                    
                }.pickerStyle(SegmentedPickerStyle())
                .padding(5)
                
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
                }
            }
            .navigationBarTitle("Movies")
        }.accentColor(.white)
    }
}



struct FilteredMoviesGridView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredMoviesGridView()
    }
}
