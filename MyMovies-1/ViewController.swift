//
//  ViewController.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/14/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MovieManagerDelegate {
    

    var movieManager: MovieManager!
    var loadingAlert: UIAlertController!
    
    
    // MARK: - MovieManagerDelegate 
    
    func didLoadMovies() {
        print("Did load movie!")
        dismiss(animated: true, completion: nil)
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
        
        self.present(alert, animated: true, completion: nil)
    }

    
    
    
    // MARK: - View Lifecycle
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        movieManager.loadMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // movieManager.loadMovieData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movieManager = MovieManager()
        movieManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

