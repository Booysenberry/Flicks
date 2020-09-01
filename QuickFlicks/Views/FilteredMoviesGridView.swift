//
//  FilteredMovieView.swift
//  QuickFlicks
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
        appearance.backgroundColor = .systemRed
    }
    
    @ObservedObject private var filteredMovieVM = FilteredMovieGridViewModel()
    @ObservedObject private var pickerModel = PickerModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Picker(selection: $pickerModel.filter, label: Text("Select")) {
                    ForEach(0 ..< pickerModel.pickerOptions.count) {
                        Text(pickerModel.pickerOptions[$0])
                    }
                }.onReceive(pickerModel.$filter) { (value) in
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
                
                ScrollView {
                    
                    LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                        
                        ForEach(filteredMovieVM.movies, id:\.id) { movie in
                            
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                
                                MovieGridItemView(movies: movie)
                                
                            }.buttonStyle(PlainButtonStyle())
                            
                            .onAppear(perform: {
                                if movie == self.filteredMovieVM.movies.last {
                                    
                                    switch pickerModel.filter {
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
                .navigationBarTitle("Movies")
            }
        }.accentColor(.white)
    }
}


struct FilteredMoviesGridView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredMoviesGridView()
    }
}
