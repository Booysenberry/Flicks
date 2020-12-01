//
//  FilteredTVShowsView.swift
//  Flicks
//
//  Created by Brad B on 22/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct FilteredTVShowsGridView: View {
    
    @StateObject private var filteredTVVM = TVShowListViewModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                if filteredTVVM.shows.isEmpty {
                    
                    Spacer()
                    
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5, anchor: .center)
                            .padding()
                        
                        Text("Connecting...")
                    }
                    
                    Spacer()
                    
                } else {
                    ScrollView {
                        
                        LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                            
                            ForEach(filteredTVVM.shows, id:\.id) { show in
                                
                                NavigationLink(destination: TVShowDetailView(show: show)) {
                                    
                                    TVShowGridItemView(shows: show)
                                    
                                }.buttonStyle(PlainButtonStyle())
                                
                                .onAppear(perform: {
                                    if show == self.filteredTVVM.shows.last {
                                        
                                        switch filteredTVVM.filter {
                                        case "popularity":
                                            self.filteredTVVM.fetchShows(filter: "popularity")
                                        case "vote_average":
                                            self.filteredTVVM.fetchShows(filter: "vote_average")
                                        default:
                                            self.filteredTVVM.fetchShows(filter: "popularity")
                                        }
                                    }
                                })
                            }
                        }
                    }
                }
            }.padding(5)
            
            .navigationBarItems(trailing:
                                    Menu {
                                        Button(action: filteredTVVM.topRated, label: {
                                            Text("Top Rated")
                                            Image(systemName: "star.fill")
                                            
                                        })
                                        
                                        Button(action: filteredTVVM.popular, label: {
                                            Text("Trending")
                                            Image(systemName: "flame.fill")
                                            
                                        })
                                    } label: {
                                        Label(
                                            title: { Text("\(filteredTVVM.label)") },
                                            icon: { Image(systemName: filteredTVVM.icon) }
                                        ).frame(width: 120)
                                    }
            )
            .navigationBarTitle("TV Shows")
        }.accentColor(.white)
    }
}

struct FilteredTVShowsGridView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredTVShowsGridView()
    }
}
