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
            
            guard let entries = json["feed"]["entry"].array else {
                print("No entries??")
                return
            }
            
            print("Entries: \(entries.count)")
            
            self.movies = []
            
            for entry in entries {
                self.movies.append(Movie(jsonRSS: entry))
            }
            
            if let delegate = self.delegate {
                DispatchQueue.main.async {
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
