//
//  WatchedMovie.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/24/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import Foundation

class WatchedMovie {
    var id: String
    var rating: Int = 0
    
    init(id: String) {
        self.id = id
    }
    
    init(id: String, rating: Int) {
        self.id = id
        self.rating = rating
    }
}
