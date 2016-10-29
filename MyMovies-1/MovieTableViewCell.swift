//
//  MovieTableViewCell.swift
//  MyMovies
//
//  Created by mitchell hudson on 10/14/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var ratingLabel: RatingLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
