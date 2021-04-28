//
//  SettingsViewController.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 1/15/21.
//

import UIKit
import FirebaseAuth
import Firebase

private let reuseIdentifier = "SettingsCell"

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    // iboutlet for the table cell inside the settings view controller
    @IBOutlet weak var tableView: UITableView!
    
    // arrays of the sections and the field of each sections
    let sections = ["Account", "Help & Support", "Delete Account"]
    let items = [
        ["Edit Profile", "Notifications", "Payment Method",
        "Contact Us", "Agrement & Acknowledgement", "iOS Team","About this App",
        "Delete Account"]
    ]
    //var identities = [String]()
    var identities = ["Edit Profile", "Notifications","Payment Method","Contact Us","Agrement & Acknowledgement","iOS Team","About this App","Delete Account"]
    var myIndex = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI() //function for customizing the settings page
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //identities = ["A", "B","C","D","E","F","G","H"]
    }
    
    // height between between each sections
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

    /*
    // the title header for each of the 3 sections created
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    // return the amount of sections i want created
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
 */
    // returns the items insde each sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    // dequeing and reusing cells if there was one already created
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        
        return cell
    }
    
    // the color of the sections cells
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.purple
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // action to be performed when a cell is clicked 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //let vcName = identities[indexPath.row]
        
        myIndex = indexPath.row
        var segueIdentifier = ""
        
        //3 lines are suppsoed to be commented out "SB, print, performsegue".
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //print("selected iten is \(items[indexPath.section][indexPath.row])")
        //performSegue(withIdentifier: "showdetail", sender: self)
        
       // if let viewController = storyboard?.instantiateViewController(withIdentifier: identities[myIndex]){
         //   self.navigationController?.pushViewController(viewController, animated: true)
        //}
        //self.navigationController?.pushViewController(viewController!, animated: true)
        //let segueIdentifier = ""
        switch myIndex {
                  case 0:
                    segueIdentifier = "A"
                  case 1:
                    segueIdentifier = "B"
                  case 2:
                    segueIdentifier = "C"
                  case 3:
                    segueIdentifier = "D"
                  case 4:
                    segueIdentifier = "E"
                  case 5:
                    segueIdentifier = "F"
                  case 6:
                    segueIdentifier = "G"
                  case 7:
                    segueIdentifier = "H"
                  default:
                    print("Index greater than vcs")
                }
         performSegue(withIdentifier: segueIdentifier, sender: self)
        //performSegue(withIdentifier: sections[indexPath.row], sender: self)
    }
    
    /*
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var row = self.tableView.indexPathForSelectedRow()!.row
        var section = self.tableView.indexPathForSelectedRow()!.section

        var destinationViewController = segue.destination as! ViewController

        destinationViewController.UserDefault.setObject(sections[section][row], forKey: "selected")
    }*/
    
    //Sign out fucntion
    @objc func handleSignOutButtonTapped(){
        let auth = Auth.auth()
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive){(action) in
            do{
                try auth.signOut()
                // bring back to log in page after signing out
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginNavController = storyboard.instantiateViewController(identifier: "NavigationController")

                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
            } catch let err {
                // need to update this beacuse you want to show the error message in the app
                print("Failed to sign out" ,err)
            }
        }
        // Adding a mesage to the action view controller
        let actionSheet = UIAlertController(title: nil, message: "Are you sure you want to sign out" , preferredStyle: .actionSheet)
        
        // adding the sign out and cancel action so it can be done
        actionSheet.addAction(signOutAction)
        actionSheet.addAction(cancelAction)
        
        // Showing the action sheet on the screen
        present(actionSheet,animated: true, completion: nil)
    }
         
    func configureUI() {
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.isTranslucent = false
        //navigationController?.navigationBar.barStyle = .black
        //navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        //navigationItem.title = "Settings"
        
        self.title = "Settings"
        
        // custumazation of settings view controller and emplacement of the sign out button
        view.backgroundColor = .red
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(handleSignOutButtonTapped))
    }
}



