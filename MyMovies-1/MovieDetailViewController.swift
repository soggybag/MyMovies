//
//  MovieDetailViewController.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/14/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, RatingLabelDelegate {

    var movie: Movie? = nil
    var id: String? = nil
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: RatingLabel!
    @IBOutlet weak var watchButton: UIButton!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var sumaryText: UITextView!
    @IBOutlet weak var movieImage: UIImageView!
    
    // MARK: IBActions
    
    @IBAction func addToWatchList(_ sender: UIButton) {
        if let movie = movie {
            if WatchList.sharedInstance.getRatingFor(id: movie.id) != nil {
                WatchList.sharedInstance.setRatingFor(id: movie.id, rating: ratingLabel.rating)
            } else {
                WatchList.sharedInstance.addMovie(id: movie.id, rating: ratingLabel.rating)
            }
        }
    }
    
    
    // MARK: Rating Label Delegate
    
    func didSetRating(sender: RatingLabel) {
        self.ratingValueLabel.text = "\(sender.rating)"
    }
    
    
    func formatMillis(ms: Int) -> String {
        let secs = ms / 1000
        let mins = secs / 60
        let hrs = mins / 60
        return "\(hrs):\(mins % 60):\(secs % 60)"
    }
    
    func loadImage(path: String) {
        let url = URL(string: path)!
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            self.movieImage.image = UIImage(data: data)
        }
        session.resume()
    }
    
    
    func loadMovie(id: String) {
        let path = "https://itunes.apple.com/lookup?id=\(id)"
        print(path)
        if let url = URL(string: path) {
            let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let response = response else {
                    print("response nil")
                    return
                }
                
                guard let results = JSON(data: data!)["results"].array else {
                    return
                }
                
                if results.count == 0 {
                    print("There were no results?")
                    return
                }
                
                let json = results[0]
                
                let kind = json["kind"].string!
                let artistName = json["artistName"].string!
                let trackName = json["trackName"].string!
                let trackPrice = json["trackHdPrice"].float!
                let primaryGenreName = json["primaryGenreName"].string!
                let shortDescription = json["shortDescription"].string!
                let longDescription = json["longDescription"].string!
                let trackTimeMillis = json["trackTimeMillis"].int!
                let releaseDate = json["releaseDate"].string!
                let artworkUrl100 = json["artworkUrl100"].string!
                let id = String(json["trackId"].int!)
                
                print(kind, artistName, trackName, trackPrice, primaryGenreName, shortDescription, longDescription, trackTimeMillis, artworkUrl100)
                
                DispatchQueue.main.async {
                    self.titleLabel.text = trackName
                    self.genreLabel.text = primaryGenreName
                    self.timeLabel.text = self.formatMillis(ms: trackTimeMillis)
                    self.sumaryText.text = longDescription
                    self.loadImage(path: artworkUrl100)
                    
                    if let rating = WatchList.sharedInstance.getRatingFor(id: id) {
                        self.ratingValueLabel.text = "\(rating)"
                    } else {
                        self.ratingValueLabel.text = ""
                    }
                }
            }
            session.resume()
        }
    }
    
    
    func setRatingFor(id: String) {
        if let rating = WatchList.sharedInstance.getRatingFor(id: id) {
            ratingLabel.rating = rating
            print("This movie is in the watch list")
            watchButton.setTitle("Change Rating", for: .normal)
        }
    }
    
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movie = movie {
            loadMovie(id: movie.id)
            setRatingFor(id: movie.id)
        }
        
        if let id = id {
            loadMovie(id: id)
            setRatingFor(id: id)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ratingLabel.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
