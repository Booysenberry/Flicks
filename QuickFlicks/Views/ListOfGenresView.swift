//
//  ListOfGenresView.swift
//  QuickFlicks
//
//  Created by Brad B on 1/09/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct ListOfGenresView: View {
    
    @ObservedObject private var genreListVM = GenreListViewModel()
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                GenreRowView(genres: genreListVM.fetchedGenres)
                
            }.navigationBarTitle("Genres")
                .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfGenresView()
    }
}
