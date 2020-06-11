//
//  ShortlistView.swift
//  QuickFlicks
//
//  Created by Brad B on 10/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct ShortlistView: View {
    
    @ObservedObject private var shortlistVM = ShortListViewModel()
    
    var genre: GenreElement
    
    var body: some View {
        
        List {
            
            ForEach(shortlistVM.fetchedMovies, id: \.id) { movie in
                
                NavigationLink(destination: DetailView()) {
                    
                    Text("\(movie.title!)")
                }
            }
        }.onAppear {
            self.shortlistVM.fetchMovies(genre: self.genre.id)
        }
        .navigationBarTitle("\(genre.name) Movies")
    }
}

struct ShortlistView_Previews: PreviewProvider {
    static var previews: some View {
        ShortlistView(genre: GenreElement(id: 1, name: "Action"))
    }
}
