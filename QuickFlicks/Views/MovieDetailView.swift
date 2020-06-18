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
    
    var movie: MoviesViewModel
    
    var body: some View {
        
        VStack {
            
            URLImage(url: "\(movie.backdropURL)")
                .aspectRatio(contentMode: .fit)
            
            Text("\(movie.movieRunTime)")
            
            Text(movie.movieOverview)
                .padding()
            
            Spacer()
            
        }.onAppear {
            self.detailVM.getMovieDetails(id: self.movie.id)
        }
        .navigationBarTitle(movie.movieTitle)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MoviesViewModel(movie: Movie.example))
    }
}




