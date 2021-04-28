//
//  CocoaLaundryViewController.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 3/30/21.
//

import UIKit
import SwiftUI

class CocoaLaundryViewController: UIViewController {

    @IBOutlet weak var theContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // wrap function in order to be able to use Swift view on top of a storyboard view
        let childView = UIHostingController(rootView: LaundryVC())
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
    }

}
