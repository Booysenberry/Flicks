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
            
            FilteredMovieView()
                .tabItem{
                    Image(systemName: "film")
                    Text("Movies")
            }
            
            GenresView()
                .tabItem {
                    Image(systemName: "film")
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
