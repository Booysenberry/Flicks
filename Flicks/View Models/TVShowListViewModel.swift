//
//  TVShowListViewModel.swift
//  Flicks
//
//  Created by Brad B on 22/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class TVShowListViewModel: ObservableObject {
    
    @Published var shows = [Show]()
    @Published var label = "Trending"
    @Published var icon = "flame.fill"
    
    private var fetchedShows = [TVShowList]()
    
    var filter = "popularity"
    var currentPage = 1
    
    init() {
        fetchShows(filter: filter)
        currentPage += 1
    }
    
    func checkTotalShows(filter: String) {
        if fetchedShows.count < 20 {
            currentPage = currentPage + 1
            fetchShows(filter: filter)
        }
    }
    
    func fetchShows(filter: String) {
        
        WebService().getTVShowsByFilter(page: currentPage, filter: filter) { show in
            
            if let show = show {
                self.fetchedShows.append(show)
                for show in show.shows {
                    self.shows.append(show)
                }
            }
        }
        if let totalPages = fetchedShows.first?.totalPages {
            if currentPage <= totalPages {
                currentPage += 1

            }
        }
    }
    
    func filterResults(filterBy: String) {
        
        shows.removeAll()
        currentPage = 1
        fetchShows(filter: filter)
        
        switch filterBy {
        case "popularity":
            label = "Trending"
            icon = "flame.fill"
            filter = "popularity"
        case "vote_average":
            label = "Top Rated"
            icon = "star.fill"
            filter = "vote_average"
        default:
            label = "Trending"
            icon = "flame.fill"
        }
    }
    
    func topRated() {
        filter = "vote_average"
        filterResults(filterBy: filter)
    }
    
    func popular() {
        filter = "popularity"
        filterResults(filterBy: filter)
    }
}
