//
//  WatchList.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/24/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import Foundation


protocol WatchListDelegate {
    func didLoadMovies()
}


// Singleton
class WatchList {
    // This is a singleton
    
    static let sharedInstance = WatchList()
    let defaults = UserDefaults.standard
    let key_watchList = "WatchList"
    
    var delegate: WatchListDelegate? = nil
    
    var watchList = [String: Int]()
    
    var count: Int {
        get {
            return watchList.count
        }
    }
    
    var allIds: String {
        get {
            var str = ""
            for (id, _) in watchList {
                str += id + ","
            }
            return str
        }
    }
    
    // Some methods 
    
    // Add a new movie to the watch list
    
    func addMovie(id: String, rating: Int) {
        print("Addmovie to watch list \(id) \(rating)")
        if watchList[id] == nil {
            watchList[id] = rating
            saveWatchList()
        }
    }
    
    func removeMovie(id: String) {
        watchList.removeValue(forKey: id)
        saveWatchList()
    }
    
    func setRatingFor(id: String, rating: Int) {
        if watchList[id] != nil {
            watchList[id] = rating
            saveWatchList()
        }
    }
    
    func getRatingFor(id: String) -> Int? {
        return watchList[id]
    }
    
    func isWatched(id: String) -> Bool {
        return watchList[id] != nil
    }
    
    // Save the watch list to user defaults
    
    func saveWatchList() {
        defaults.set(watchList, forKey: key_watchList)
        defaults.synchronize()
    }
    
    // Get the watchlist from user defaults

    func getWatchList() {
        if let watchList = defaults.object(forKey: key_watchList) {
            self.watchList = watchList as! [String: Int]
        }
    }
    
    // MARK: - Init
    
    init() {
        getWatchList()
    }
 
}
