//
//  FilmographyView.swift
//  QuickFlicks
//
//  Created by Brad B on 26/08/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct FilmographyView: View {
    
    @ObservedObject var filmographyVM = FilmographyViewModel()
    
    var cast: Actors
    
     var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center, spacing: 50) {
                
                URLImage(url: "\(cast.profileURL)", type: "cast")
                    .clipShape(Circle())
                    .frame(width: 92, height: 136)
                
            }.padding()
            
            Text("Filmography").font(.largeTitle)
            
            ScrollView {
                
                LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                    
                    ForEach(filmographyVM.fetchedRoles, id:\.id) { movie in
                        
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            
                            MovieGridItemView(movies: movie)
                            
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }

        }.onAppear(perform: {
            filmographyVM.getRoles(actor: cast.id ?? 0)
        })
        Spacer()
            .navigationTitle(cast.name!)
    }
}

//struct FilmographyView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        FilmographyView(cast: Actors.example)
//    }
//}
