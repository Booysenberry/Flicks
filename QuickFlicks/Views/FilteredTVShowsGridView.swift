//
//  FilteredTVShowsView.swift
//  QuickFlicks
//
//  Created by Brad B on 22/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct FilteredTVShowsGridView: View {
    
    @ObservedObject private var filteredTVVM = TVShowListViewModel()
    @ObservedObject private var pickerModel = PickerModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Picker(selection: $pickerModel.filter, label: Text("Select")) {
                    ForEach(0 ..< pickerModel.pickerOptions.count) {
                               Text(pickerModel.pickerOptions[$0])
                            }
                         }.onReceive(pickerModel.$filter) { (value) in
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
                
                ScrollView {
                    
                    LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                        
                        ForEach(filteredTVVM.shows, id:\.id) { show in
                            
                            NavigationLink(destination: TVShowDetailView(show: show)) {
                                
                                TVShowGridItemView(shows: show)
                                
                            }.buttonStyle(PlainButtonStyle())
                            
                            .onAppear(perform: {
                                if show == self.filteredTVVM.shows.last {
                                    
                                    switch pickerModel.filter {
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
                }.navigationBarTitle("Popular TV")
            }
        }
    }
}

struct FilteredTVShowsGridView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredTVShowsGridView()
    }
}
