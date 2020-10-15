//
//  ListOfGenresView.swift
//  Flicks
//
//  Created by Brad B on 1/09/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct ListOfGenresView: View {
    
    @ObservedObject private var genreListVM = GenreListViewModel()
    
    var body: some View {
        
        NavigationView {
            
            if genreListVM.fetchedGenres.isEmpty {
                
                Spacer()
                
                VStack {
                    ProgressView()
                        .scaleEffect(1.5, anchor: .center)
                        .padding()
                    
                    Text("Connecting...")
                    
                }.navigationBarTitle("Genres")
                
                Spacer()
                
            } else {
                List {
                    
                    GenreRowView(genres: genreListVM.fetchedGenres)
                    
                }.navigationBarTitle("Genres")
            }
        }.accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfGenresView()
    }
}
