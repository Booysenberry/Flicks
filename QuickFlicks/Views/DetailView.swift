//
//  DetailView.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject private var detailVM = DetailViewModel()
    
    var movie: Result
    
    var body: some View {
        
        VStack {
            
            MovieDetailsView(movie: movie)
            
            Text("\(movie.overview!)")
            
            Spacer()
            
            }.onAppear {
                self.detailVM.getMovieDetails(id: self.movie.id!)
            }
        .navigationBarTitle("Movie Details")
            .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: Result(popularity: 6, voteCount: 100, video: false, posterPath: "/aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg", id: 454626, adult: false, backdropPath: "/stmYfCUGd8Iy6kAMBr6AmWqx8Bq.jpg", originalTitle: "Sonic the Hedgehog", genreIDS: [28,35,878,10751], title: "Sonic the Hedgehog", voteAverage: 6.7, overview: "Based on the global blockbuster videogame franchise from Sega, Sonic the Hedgehog tells the story of the world’s speediest hedgehog as he embraces his new home on Earth. In this live-action adventure comedy, Sonic and his new best friend team up to defend the planet from the evil genius Dr. Robotnik and his plans for world domination.", releaseDate: "2020-02-12"))
    }
}

struct RatingView: View {
    
    var movie: Result
    
    var body: some View {
        
        VStack {
            HStack {
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
                if movie.voteAverage != nil {
                    Text("\(movie.voteAverage!)")
                }
                
            }
            HStack {
                
                Image(systemName: "person.3.fill")
                
                if movie.voteCount != nil {
                Text("\(movie.voteCount!)")
                }
            }
        }
    }
}

struct MovieDetailsView: View {
    
    var movie: Result
    
    var body: some View {
        HStack {
            
            Image("sample")
                .resizable()
                .frame(width: 100, height: 150)
            
            VStack(alignment: .leading) {
                
                if movie.title != nil {
                    Text(movie.title!)
                    .font(.largeTitle)
                }
                
                if movie.releaseDate != nil {
                    Text(movie.releaseDate!)
                }
                
                RatingView(movie: movie)
                
            }
            Spacer()
        }
    }
}
