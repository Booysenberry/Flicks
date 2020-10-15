//
//  WebService.swift
//  Flicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class WebService {
    
    private let apiKey = valueForAPIKey(keyname: "YOUR_APPLICATION_KEY")
    
    func getGenres(completion: @escaping (Genre?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
    
    func getMoviesByFilter(filter: String, page: Int, completion: @escaping (MovieList?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=\(filter).desc&include_adult=false&include_video=false&page=\(page)&vote_count.gte=100") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
                    print(movies.movies.count)
                    completion(movies)
                }
                
            } catch let err {
                print("Error", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
    
    func getMoviesByGenre(filter: String, genre: Int, page: Int, completion: @escaping (MovieList?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=\(filter).desc&include_adult=false&include_video=false&page=\(page)&with_genres=\(genre)&vote_count.gte=100") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie)?api_key=\(apiKey)&append_to_response=credits") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
        
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(movie)&page=\(page)&include_adult=false&append_to_response=credits"
        
        guard let encodedUrl = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!) else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: encodedUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
                    
                }
                
            } catch let err {
                print("Err", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
    
    func searchForShow(show: String, page: Int, completion: @escaping (TVShowList?) -> ()) {
        
        let url = "https://api.themoviedb.org/3/search/tv?api_key=\(apiKey)&language=en-US&page=\(page)&query=\(show)&include_adult=false"
        
        guard let encodedUrl = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!) else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: encodedUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
                let showDetails = try decoder.decode(TVShowList.self, from: data)
                
                DispatchQueue.main.async {
                    
                    completion(showDetails)
                    
                }
                
            } catch let err {
                print("Err", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
    
    func getPopularTVShows(page: Int, filter: String, completion: @escaping (TVShowList?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(filter)?api_key=\(apiKey)&language=en-US&page=\(page)") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
                let shows = try decoder.decode(TVShowList.self, from: data)
                
                DispatchQueue.main.async {
                    completion(shows)
                }
                
            } catch let err {
                print("Error", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
    
    func getTVCast(show: Int, completion: @escaping (ShowCast?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(show)/credits?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
                let cast = try decoder.decode(ShowCast.self, from: data)
                
                DispatchQueue.main.async {
                    completion(cast)
                    
                }
                
            } catch let err {
                print("Error", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
    
    func getRoles(actor: Int, completion: @escaping (FilmographyList?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(actor)/combined_credits?api_key=5228bff935f7bd2b18c04fc3439828c0&language=en-US&append_to_response=details") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
                let roles = try decoder.decode(FilmographyList.self, from: data)
                
                DispatchQueue.main.async {
                    completion(roles)
                    
                }
                
            } catch let err {
                print("Error", err)
            }
        }
        // execute the HTTP request
        task.resume()
    }
    
    func getRecommendedMovies(movie: Int, completion: @escaping (RecommendedMovies?) -> ()) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie)/recommendations?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 15.0)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
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
                let movies = try decoder.decode(RecommendedMovies.self, from: data)
                
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
}
