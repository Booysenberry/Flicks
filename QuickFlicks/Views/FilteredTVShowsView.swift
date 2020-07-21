//
//  FilteredTVShowsView.swift
//  QuickFlicks
//
//  Created by Brad B on 22/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct FilteredTVShowsView: View {
    
    @ObservedObject private var filteredTVVM = TVShowListViewModel()
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                LazyVGrid(columns: twoColumnGrid, spacing: 10) {
                    
                    ForEach(filteredTVVM.shows, id:\.id) { show in
                        
                        NavigationLink(destination: TVShowDetailView(show: show)) {
                            
                            TVShowRowView(shows: show)
                            
                        }.buttonStyle(PlainButtonStyle())
                        
                        .onAppear(perform: {
                            if show == self.filteredTVVM.shows.last {
                                self.filteredTVVM.fetchShows()
                            }
                        })
                    }
                }
            }.navigationBarTitle("Popular TV")
        }
    }
}

struct FilteredTVShowsView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredTVShowsView()
    }
}
