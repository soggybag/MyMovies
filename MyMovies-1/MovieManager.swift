//
//  MovieManager.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/14/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import Foundation

protocol MovieManagerDelegate {
    func didLoadMovies()
    func didStartLoadingMovies()
}

class MovieManager {
    static let sharedInstance = MovieManager()
    
    var delegate: MovieManagerDelegate?
    var movies = [Movie]()
    var watchedMovies = [String: Int]()
    
    var count: Int {
        get {
            return movies.count
        }
    }
    
    
    // MARK: Watched Movies 
    
    func watchMovie(id: String, rating: Int) {
        watchedMovies[id] = rating
    }
    
    
    
    // MARK: Get Top 25 Movies
    
    func loadMovieData() {
        // TODO: Display loading spinner
        if let delegate = delegate {
            delegate.didStartLoadingMovies()
        }
        
        let apiToContact = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        let url = URL(string: apiToContact)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let data = data else {
                print("Data Error")
                return
            }
            
            let json = JSON(data: data)
            // print(json)
            // print(json["feed"]["author"]["name"]["label"].string)
            // print(json["feed"]["entry"][0]["im:name"]["label"].string)
            guard let entries = json["feed"]["entry"].array else {
                print("No entries??")
                return
            }
            
            print("Entries: \(entries.count)")
            
            self.movies = []
            
            for entry in entries {
                guard let name = entry["im:name"]["label"].string,
                    let category = entry["category"]["attributes"]["label"].string,
                    let id = entry["id"]["attributes"]["im:id"].string,
                    let imageURL60 = entry["im:image"][0]["label"].string,
                    let imageURL170 = entry["im:image"][2]["label"].string,
                    let summary = entry["summary"]["label"].string,
                    let artist = entry["im:artist"]["label"].string
                
                else {
                        print("Bad entry")
                        return
                }
                
                // print(Float(entry["link"][1]["im:duration"]["label"].string!))
                
                let movie = Movie(name: name,
                                  category: category,
                                  id: id,
                                  imageURL60: imageURL60,
                                  imageURL170: imageURL170,
                                  summary: summary,
                                  artist: artist,
                                  duration: 0)
                
                self.movies.append(movie)
            }
            
            // print("*** Movie count: \(self.movies.count)")
            
            if let delegate = self.delegate {
                DispatchQueue.main.async {
                    // print(">>> Dispatch Queue")
                    // print("movies: \(self.movies.count)")
                    delegate.didLoadMovies()
                }
                
            }
        })
        
        task.resume()
    }
    
    
    func checkWatchedMovies() {
        
    }
    
    
    // MARK: Init 
    
    init() {
        
    }
}
