//
//  Top25TableViewController.swift
//  MyMovies
//
//  Created by mitchell hudson on 10/14/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import UIKit

class Top25TableViewController: UITableViewController, MovieManagerDelegate {
    
    var loadingAlert: UIAlertController!
    
    
    // MARK: - MovieManagerDelegate
    
    func didLoadMovies() {
        print("Did load movie!")
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    func didStartLoadingMovies() {
        print("Started loading movies")
        let alert = UIAlertController(title: "Loading", message: "\n\n\n\n", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: alert.view.bounds)
        indicator.activityIndicatorViewStyle = .gray
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()
        
        alert.view.addSubview(indicator)
        loadingAlert = alert
        
        
        // var vc = storyboard?.instantiateViewController(withIdentifier: "WaitingViewController")
        
        
        
        self.present(alert, animated: true, completion: nil)
    }

    
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MovieManager.sharedInstance.loadMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieManager.sharedInstance.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("Number of rows: \(MovieManager.sharedInstance.count)")
        return MovieManager.sharedInstance.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        
        let movie = MovieManager.sharedInstance.movies[indexPath.row]
        cell.movieNameLabel.text = movie.name
        cell.movieGenreLabel.text = movie.category
        
        print(WatchList.sharedInstance.getRatingFor(id: movie.id))
        
        if let rating = WatchList.sharedInstance.getRatingFor(id: movie.id) {
            cell.ratingLabel.text = "\(rating)"
            cell.starsLabel.rating = rating
        } else {
            cell.starsLabel.rating = 0
            cell.ratingLabel.text = "n/a"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let watch = UITableViewRowAction(style: .normal, title: "Watch") { (action, indexPath) in
            
        }
        
        return [watch]
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsSegue" {
            let vc = segue.destination as! MovieDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let movie = MovieManager.sharedInstance.movies[indexPath.row]
                vc.movie = movie
            }
        }
    }
    

}
