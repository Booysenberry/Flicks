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
    
    
    
    func getMoviesByGenre(genre: Int, page: Int, completion: @escaping (MovieList?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=5228bff935f7bd2b18c04fc3439828c0&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_genres=\(genre)") else {
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
                let movies = try decoder.decode(MovieList.self, from: data)
                
                DispatchQueue.main.async {
                    
                    completion(movies)
                    
                }
                
            } catch let err {
                print("Error", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
    
    func getMovieDetails(movie: Int, completion: @escaping (Movie?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie)?api_key=5228bff935f7bd2b18c04fc3439828c0&append_to_response=similar") else {
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
                let movieDetails = try decoder.decode(Movie.self, from: data)
                
                DispatchQueue.main.async {
                    
                    completion(movieDetails)
                    
                    
                    
                }
                
            } catch let err {
                print("Err", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
    
    func searchForMovie(movie: String, page: Int, completion: @escaping (MovieList?) -> ()) {
        
        let url = "https://api.themoviedb.org/3/search/movie?api_key=5228bff935f7bd2b18c04fc3439828c0&language=en-US&query=\(movie)&page=\(page)&include_adult=false"
        
        guard let enccodedUrl = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!) else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: enccodedUrl) { data, response, error in
            
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
                let movieDetails = try decoder.decode(MovieList.self, from: data)
                
                DispatchQueue.main.async {
                    
                    completion(movieDetails)
                    print(url)
                    
                }
                
            } catch let err {
                print("Err", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
}
