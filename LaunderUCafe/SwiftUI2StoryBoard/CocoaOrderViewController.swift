//
//  CocoaOrderViewController.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 2/23/21.
//

import UIKit
import SwiftUI

class CocoaOrderViewController: UIViewController {
    
    @IBOutlet weak var theContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // wrap function in order to be able to use Swift view on top of a storyboard view
        let childView = UIHostingController(rootView: OrderViewController())
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
    }

}
