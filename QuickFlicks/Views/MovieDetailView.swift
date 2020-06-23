//
//  DetailView.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    @ObservedObject private var detailVM = DetailViewModel()
    
    var movie: Movie
    
    var body: some View {
        
        VStack {
            
            URLImage(url: "\(movie.backdropURL)")
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Image(systemName: "play.rectangle")
                Text("\(detailVM.fetchedMovie?.runTime ?? 1) mins")
                
            }
            
    
            
            Text(movie.overview)
            .padding()
            
            Spacer()
            
        }.onAppear {
            self.detailVM.getMovieDetails(id: self.movie.id)
        }
        .navigationBarTitle(movie.title)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.example)
    }
}




