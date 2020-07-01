//
//  SearchView.swift
//  QuickFlicks
//
//  Created by Brad B on 29/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var searchVM = SearchViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                SearchBarView(searchVM: searchVM, text: $searchText)
                
                List {
                    
                    ForEach(searchVM.searchedMovies, id: \.id) { movie in
                        
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            
                            MovielistRowView(movies: movie)
                            
                            .onAppear(perform: {
                                if movie == self.searchVM.searchedMovies.last {
                                    self.searchVM.checkTotalMovies(movie: self.searchText)
                                    
                                }
                            })
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
