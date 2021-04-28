//
//  HomeViewController.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 1/15/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDateTime()
    }
    
    
    func getCurrentDateTime(){
    
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the formatter and set the style
        let formatter = DateFormatter()
        //formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        // gets the date and time string from the date object
        let dataTimeString = formatter.string(from: currentDateTime)
        
        // assign it to the label
        dateLabel.text = dataTimeString
    }
    
    
}
