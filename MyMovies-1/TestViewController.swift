//
//  TestViewController.swift
//  MyMovies-1
//
//  Created by mitchell hudson on 10/26/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    
    var array = [String]()
    
    
    // MARK: IBoutlets
    
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: IBActions
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let str = textField.text!
        // TODO: validation
        addString(str: str)
    }
    
    
    @IBAction func listButtonTapped(_ sender: UIButton) {
        listArray()
    }
    
    var shouldWatch = true
    @IBAction func watchButtonTapped(_ sender: UIButton) {
//        shouldWatch = !shouldWatch
//        
//        if shouldWatch {
//            sender.setTitle("Add to watch list", for: .normal)
//        } else {
//            sender.setTitle("Remove from watch list", for: .normal)
//        }
        
        
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            //
        } else {
            //
        }
        
    }
    
    
    
    
    // Helpers Methods
    
    // Add new string to array and save defaults
    func addString(str: String) {
        for item in array {
            if item == str {
                print("That string already exists!")
                return
            }
        }
        print("New String added!")
        array.append(str)
        saveDefaults()
    }
    
    func getDefaults() {
        array = UserDefaults.standard.object(forKey: "test") as! [String]
    }
    
    func saveDefaults() {
        UserDefaults.standard.set(array, forKey: "test")
        UserDefaults.standard.synchronize()
    }
    
    func listArray() {
        for str in array {
            print(str)
        }
    }
    
    
    
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDefaults()
        
        
        
        print("****************************")
        
        let array = [["a":1],["b":2],["c":3]]
        
        for item in array {
            // print(item)
            for (key, value) in item {
                // print("Key: \(key) value:\(value)")
                let watchedMovie = WatchedMovie(id: key, rating: value)
            }
        }
        
        print("****************************")
        
        
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
