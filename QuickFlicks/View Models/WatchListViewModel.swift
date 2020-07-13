//
//  WatchListViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 13/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

class WatchListViewModel: ObservableObject {
    
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var watchListMovies = [Movie]() {
        willSet {
            objectWillChange.send()
        }
    }
    
    func toAnyObject(movies: FetchedResults<SavedMovie>)  {
        
        var dic = [String:AnyObject?]()
        
        for movie in movies {
            
            dic["title"] = movie.title as AnyObject
            dic["id"] = movie.id as AnyObject
            dic["adult"] = movie.adult as AnyObject
            dic["backdropPath"] = movie.backdropPath as AnyObject
            dic["video"] = movie.video as AnyObject
            dic["popularity"] = movie.popularity as AnyObject
            dic["releaseDate"] = movie.releaseDate as AnyObject
            dic["posterPath"] = movie.posterPath as AnyObject
            dic["overview"] = movie.overview as AnyObject
            dic["voteAverage"] = movie.voteAverage as AnyObject
            dic["voteCount"] = movie.voteCount as AnyObject
            dic["runTime"] = movie.runTime as AnyObject
            
            fromAnyObjectToMovie(dictionary: dic)
        }
    }
    
    func fromAnyObjectToMovie(dictionary: [String:AnyObject?]) {
        
        let movie = Movie(
            popularity: dictionary["popularity"] as! Double,
            voteCount: dictionary["voteCount"] as! Int,
            video: (dictionary["video"] != nil),
            posterPath: dictionary["posterPath"] as? String,
            id: dictionary["id"] as! Int,
            adult: (dictionary["adult"] != nil),
            backdropPath: dictionary["backdropPath"] as? String,
            title: dictionary["title"] as! String,
            voteAverage: dictionary["voteAverage"] as! Double,
            overview: dictionary["overview"] as! String,
            releaseDate: dictionary["releaseDate"] as? String,
            runTime: dictionary["runTime"] as? Int,
            credits: nil)
        
        watchListMovies.append(movie)
    }
}
