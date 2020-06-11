//
//  ContentView.swift
//  QuickFlicks
//
//  Created by Brad B on 10/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var genreListVM = GenreListViewModel()
    
    var body: some View {
        
        NavigationView {
            
            List {
                    
                    GenreListView(genres: self.genreListVM.fetchedGenres)
            
                .navigationBarTitle("Genres")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
