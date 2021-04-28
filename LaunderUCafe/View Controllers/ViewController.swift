//
//  ViewController.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 1/15/21.
//

import UIKit

class ViewController: UIViewController {
    
    // iboutlet button for the sign up and log in button
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    // function to design the log in and sign up button
    func setUpElements(){
         
         Utilities.styleFilledButton(signUpButton)
         Utilities.styleHollowButton(logInButton)
     }
}

