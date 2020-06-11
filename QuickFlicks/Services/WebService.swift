//
//  WebService.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class WebService {
    
    func getGenres(completion: @escaping (Genre?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=5228bff935f7bd2b18c04fc3439828c0&language=en-US") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            // Check for errors
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            // Check that data has been returned
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let genres = try decoder.decode(Genre.self, from: data)
                
                DispatchQueue.main.async {
                
                   completion(genres)
                }
                
            } catch let err {
                print("Err", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
}
