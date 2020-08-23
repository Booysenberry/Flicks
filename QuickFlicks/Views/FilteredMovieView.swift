//
//  FilteredMovieView.swift
//  QuickFlicks
//
//  Created by Brad B on 16/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

class PickerModel: ObservableObject, Equatable {
    static func == (lhs: PickerModel, rhs: PickerModel) -> Bool {
        return lhs.filter == rhs.filter
    }
    
    @Published var filter = 0
}

struct FilteredMovieView: View {
    
    @ObservedObject private var filteredMovieVM = FilteredMovieViewModel()
    @ObservedObject private var pickerModel = PickerModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    let pickerOptions = ["Popular", "Top Rated"]

    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Picker(selection: $pickerModel.filter, label: Text("Select")) {
                            ForEach(0 ..< pickerOptions.count) {
                               Text(self.pickerOptions[$0])
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
                                
                                MovielistRowView(movies: movie)
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
        }
    }
}


struct FilteredMovieView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredMovieView()
    }
}
