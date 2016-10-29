//
//  Movie.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/14/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import Foundation

class Movie {
    let name: String
    let category: String
    let id: String
    let imageURL60: String
    let imageURL170: String
    let summary: String
    let artist: String
    let duration: Int
    
    var rating: Int = 0
    var watched = false
    
    var durationTime: String {
        get {
            let m = duration / 60 / 10
            let h = m / 60
            return "\(name) \(duration) \(h) : \(m)"
        }
    }
    
    init(name: String,
         category: String,
         id: String,
         imageURL60: String,
         imageURL170: String,
         summary: String,
         artist: String,
         duration: Int) {
        
        self.name = name
        self.category = category
        self.id = id
        self.imageURL60 = imageURL60
        self.imageURL170 = imageURL170
        self.summary = summary
        self.artist = artist
        self.duration = duration
    }
    
    
    // Initialize with JSON from iTunes id lookup!
    init(json: JSON) {
        // let kind = json["kind"].string!
        self.artist = json["artistName"].string!
        self.name = json["trackName"].string!
        // let trackPrice = json["trackHdPrice"].float!
        self.category = json["primaryGenreName"].string!
        // let shortDescription = json["shortDescription"].string!
        self.summary = json["longDescription"].string!
        self.duration = json["trackTimeMillis"].int!
        // let releaseDate = json["releaseDate"].string!
        self.imageURL60 = json["artworkUrl100"].string!
        self.imageURL170 = self.imageURL60
        self.id = String(json["trackId"].int!)
    }
    
    // Initialize with JSON from iTunes RSS lookup
    init(jsonRSS: JSON) {
        self.name = jsonRSS["im:name"]["label"].string!
        self.category = jsonRSS["category"]["attributes"]["label"].string!
        self.id = jsonRSS["id"]["attributes"]["im:id"].string!
        self.imageURL60 = jsonRSS["im:image"][0]["label"].string!
        self.imageURL170 = jsonRSS["im:image"][2]["label"].string!
        self.summary = jsonRSS["summary"]["label"].string!
        self.artist = jsonRSS["im:artist"]["label"].string!
        self.duration = 0
    }
    
}














