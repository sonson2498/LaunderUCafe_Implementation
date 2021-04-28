//
//  DeleteAccountVC.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 4/16/21.
//

import UIKit
import Firebase

class DeleteAccountVC: UIViewController {
    
    @IBOutlet weak var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func deleteAccount(_ sender: Any) {
        delete()
        
    }
    
    @objc func delete(){
        let user = Auth.auth().currentUser
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete Account", style: .destructive){(action) in
            
            do{
                // bring back to log in page after deletion
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginNavController = storyboard.instantiateViewController(identifier: "NavigationController")
                
                user?.delete { error in
                    if error != nil {
                        // An error happened.
                        print("An error has Occured")
                    }else {
                    // Account deleted.
                    print("Successful in deleting the account")
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
                    }
                }
            }
        }
        
        // Adding a mesage to the action view controller
        let actionSheet = UIAlertController(title: nil, message: "Are you sure you want to Delete the account" , preferredStyle: .actionSheet)
        
        // adding the sign out and cancel action so it can be done
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(deleteAction)
        
        // Showing the action sheet on the screen
        present(actionSheet,animated: true, completion: nil)
    }
}
