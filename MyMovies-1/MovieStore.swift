//
//  MovieStore.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/26/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import Foundation

class MovieStore {
    static let sharedInstance = MovieStore()
    let keyWatchList = "watchedList"
    
    var watchedMovies = [[String: Int]]()
    var movies = [Movie]()
    
    init() {
        
    }
    
    func loadMovies() {
        loadWatchedMovies()
        loadTop(count: 25)
        
        // Load Watched Movies from User Defaults
        // Load top 25
        // Sync up watched movies
    }
    
    func loadWatchedMovies() {
        if let array = UserDefaults.standard.object(forKey: keyWatchList) as? [[String: Int]] {
            watchedMovies = array
        }
    }
    
    func loadTop(count: Int) {
        var idArray = [String]()
        
        let path = "https://itunes.apple.com/us/rss/topmovies/limit=\(count)/json"
        let url = URL(string: path)!
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // TODO: Check Response
            // TODO: Check Error 
            guard let data = data else {
                print("Data nil")
                return
            }
            
            let json = JSON(data: data)
            
            guard let entries = json["feed"]["entry"].array else {
                print("No entries??")
                return
            }
            
            for entry in entries {
                let id = entry["id"]["attributes"]["im:id"].string!
                idArray.append(id)
            }
            
            self.syncWatchedMovies(idArray: idArray)
        }
    }
    
    
    func syncWatchedMovies(idArray: [String]) {
        var idArray = idArray
        for watchedMovie in watchedMovies {
            for (id, rating) in watchedMovie {
                if !idArray.contains(id) {
                    idArray.append(id)
                }
            }
        }
        
        
    }
    
    func loadMoviesFor(ids: String) {
        
    }
}






