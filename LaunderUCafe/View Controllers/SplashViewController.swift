//
//  SplashViewController.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 4/21/21.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoader()
        login()
    }
    
    private func setLoader(){
        
        indicator.color = UIColor(named: "purple")
        indicator.startAnimating()
    }

    private func login(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "NavigationController")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            
            self.present(mainTabBarController, animated: false)
        })
        return
    }
}
