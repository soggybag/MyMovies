//
//  WatchedViewController.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/25/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import UIKit

class WatchedViewController:
UIViewController,
UITableViewDataSource,
UITableViewDelegate,
WatchListDelegate {
    
    var watchedArray = [Movie]()
    
    func loadWatchedMovies() {
        let path = "https://itunes.apple.com/lookup?id=\(WatchList.sharedInstance.allIds)"
        print(path)
        if let url = URL(string: path) {
            let session = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
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
                
                self.watchedArray = []
                for json in results {
                    self.watchedArray.append(Movie(json: json))
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            session.resume()
        }
        // load movie details
        // refresh table view
    }
    
    
    // MARK: - IBOutlets 
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Table View 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let movie = watchedArray[indexPath.row]
        cell.textLabel?.text = movie.name
        let url = URL(string: movie.imageURL60)!
        
         let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
        session.resume()
        
        return cell
    }
    
    
    // MARK: Watch List Delegate
    
    func didLoadMovies() {
        print("Watch list did load movies")
        tableView.reloadData()
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("*** Watched List view will appear")
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        loadWatchedMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromWatchListSegue" {
            let vc = segue.destination as! MovieDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.id = watchedArray[indexPath.row].id
            }
        }
    }
    

}
