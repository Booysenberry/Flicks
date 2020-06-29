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
    
    init() {
        searchVM.fetchMovies(movie: "Star+Wars")
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                SearchBarView(text: $searchText)
                
                List {
                    
                    ForEach(searchVM.searchedMovies, id: \.id) { movie in
                        
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            
                            MovielistRowView(movies: movie)
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
