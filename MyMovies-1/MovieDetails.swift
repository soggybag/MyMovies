//
//  MovieDetails.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/26/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import Foundation

class MovieDetails {
    
    var kind: String
    var artistName: String
    var trackName: String
    var trackPrice: Float
    var primaryGenreName: String
    var shortDescription: String
    var longDescription: String
    var trackTimeMillis: Int
    var releaseDate: String
    var artworkUrl100: String
    
    init(json: JSON) {
        self.kind = json["kind"].string!
        self.artistName = json["artistName"].string!
        self.trackName = json["trackName"].string!
        self.trackPrice = json["trackHdPrice"].float!
        self.primaryGenreName = json["primaryGenreName"].string!
        self.shortDescription = json["shortDescription"].string!
        self.longDescription = json["longDescription"].string!
        self.trackTimeMillis = json["trackTimeMillis"].int!
        self.releaseDate = json["releaseDate"].string!
        self.artworkUrl100 = json["artworkUrl100"].string!
    }
}
