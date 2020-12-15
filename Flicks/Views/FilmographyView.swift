//
//  FilmographyView.swift
//  Flicks
//
//  Created by Brad B on 26/08/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct FilmographyView: View {
    
    @StateObject var filmographyVM = FilmographyViewModel()
    
    var cast: Actors
    
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center, spacing: 50) {
                
                URLImage(url: "\(cast.profileURL)", type: "cast")
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.gray, lineWidth: 2))
                    .frame(width: 92, height: 136)
                
            }
            
            Text(cast.name ?? "").font(.largeTitle)
            
            ScrollView {
                
                LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                    
                    ForEach(filmographyVM.fetchedRoles, id:\.id) { movie in
                        
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            
                            MovieGridItemView(movies: movie)
                            
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            // Banner ad
            VStack {
                Button(action: {
                    // your action here
                }) {
                    Text("Remove ads")
                }.font(.footnote)
                .foregroundColor(.blue)
                
                GADBannerViewController()
                    .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
            }
            
        }.onAppear(perform: {
            filmographyVM.getRoles(actor: cast.id ?? 0)
        })
        Spacer()
            .navigationTitle("Filmography")
    }
}

struct FilmographyView_Previews: PreviewProvider {
    
    static var previews: some View {
        FilmographyView(cast: Actors.example)
    }
}
