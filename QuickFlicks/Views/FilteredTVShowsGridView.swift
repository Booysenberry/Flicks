//
//  FilteredTVShowsView.swift
//  QuickFlicks
//
//  Created by Brad B on 22/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct FilteredTVShowsGridView: View {
    
    @StateObject private var filteredTVVM = TVShowListViewModel()
    @State var filter = 0
    private let pickerOptions = ["Popular", "Top Rated"]
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Picker(selection: $filter, label: Text("Select")) {
                    Text("Popular").tag(0)
                    Text("Top Rated").tag(1)
                }
                .onChange(of: filter) { value in
                    
                    switch value {
                    case 0:
                        filteredTVVM.shows.removeAll()
                        filteredTVVM.currentPage = 1
                        filteredTVVM.fetchShows(filter: "popular")
                    case 1:
                        filteredTVVM.shows.removeAll()
                        filteredTVVM.currentPage = 1
                        filteredTVVM.fetchShows(filter: "top_rated")
                    default:
                        filteredTVVM.shows.removeAll()
                        filteredTVVM.currentPage = 1
                        filteredTVVM.fetchShows(filter: "popular")
                    }
                    
                }.pickerStyle(SegmentedPickerStyle())
                .padding(5)
                
                if filteredTVVM.shows.isEmpty {
                    
                    Spacer()
                    
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5, anchor: .center)
                            .padding()
                        
                        Text("Please check internet connection")
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
                                        
                                        switch filter {
                                        case 0:
                                            self.filteredTVVM.fetchShows(filter: "popular")
                                        case 1:
                                            self.filteredTVVM.fetchShows(filter: "top_rated")
                                        default:
                                            self.filteredTVVM.fetchShows(filter: "popular")
                                        }
                                    }
                                })
                            }
                        }
                    }
                }
            }.navigationBarTitle("TV Shows")
        }.accentColor(.white)
    }
}

struct FilteredTVShowsGridView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredTVShowsGridView()
    }
}
