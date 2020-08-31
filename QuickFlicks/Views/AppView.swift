//
//  AppView.swift
//  QuickFlicks
//
//  Created by Brad B on 29/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        
        TabView {
            
            FilteredMoviesGridView()
                .tabItem{
                    Image(systemName: "film")
                    Text("Movies")
                }
            
            FilteredTVShowsGridView()
                .tabItem{
                    Image(systemName: "tv")
                    Text("TV")
                }
            
            ListOfGenresView()
                .tabItem {
                    Image(systemName: "list.and.film")
                    Text("Genres")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            WatchListView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Watch List")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
