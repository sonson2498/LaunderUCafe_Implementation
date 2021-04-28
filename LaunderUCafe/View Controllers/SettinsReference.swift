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

class SettingsViewController: UIViewController {
    
    //creating the table view for the settings page
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    private var userCollection: CollectionReference!
    //private var users = [User]()
    
    //let id = Auth.auth().currentUser!.uid
    //let email = Auth.auth().currentUser!.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI() //function for customizing the settings page
        //self.uid.text = id
        //emailTextField.text = email
        
        userCollection = Firestore.firestore().collection("users")
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        let db = Firestore.firestore()
        db.collection("users").whereField("capital", isEqualTo: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
        }
    }
     

     override func viewWillAppear(_ animated: Bool) {
         userCollection.getDocuments { (snapshot, error) in
             if let err = error{
                 debugPrint("Error fetching docs: \(err)")
             }else{
                 guard let snap = snapshot else{ return }
                 for document in snap.documents{
                    print(document.data())
                 }
             }
         }
     }

    override func viewWillAppear(_ animated: Bool) {
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        
        func observeCurrentUser(completion: @escaping (User) -> Void) {
           guard let currentUser = Auth.auth().currentUser else {
               return
           }
        
        db.collection("users").document(currentUser.uid)
           .getDocument { (snapshot, error ) in
                guard let dict = snapshot.value as? [String: Any] else { return }
                if let document = snapshot {
                    
                let user = CurrentUser(uid: uid, dictionary: dict)
                completion(user)

                 } else {

                  print("Document does not exist")

                 }
           }
        }
    }

     */
    
    /*
    func getName(completion: @escaping (_ name: String?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { // safely unwrap the uid; avoid force unwrapping with !
            completion(nil) // user is not logged in; return nil
            return
        }
        Firestore.firestore().collection("users").document(uid).getDocument { (docSnapshot, error) in
            if let doc = docSnapshot {
                if let name = doc.get("firstName") as? String {
                    completion(name) // success; return name
                } else {
                    print("error getting field")
                    completion(nil) // error getting field; return nil
                }
            } else {
                if let error = error {
                    print(error)
                }
                completion(nil) // error getting document; return nil
            }
        }
    }
    */
    
    
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
    
    //comfigure the table view
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
    
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
            
    func configureUI() {
        configureTableView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        navigationItem.title = "Settings"
        
        // custumazation of settings view controller and emplacement of the sign out button
        view.backgroundColor = .white
        //navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(handleSignOutButtonTapped))
    }
}

// design of the settings all the sections and row within each sections 
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //function for number of section inside the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    //how many rows you want inside a given section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else {return 0}
        
        switch section{
        case .Account: return AccountOption.allCases.count
        case .Support: return SupportOption.allCases.count
        case .Delete: return DeleteOption.allCases.count
        }
    }
    
    //header each of the sections created
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView()
        view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        
        
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        //get the text from settingSection
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    //header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSection(rawValue: indexPath.section) else {return UITableViewCell() }

        //setting up the cells for each of our sections 
        switch section{
        case .Account:
            let account = AccountOption(rawValue: indexPath.row)
            cell.textLabel?.text = account?.description
        case .Support:
            let support = SupportOption(rawValue: indexPath.row)
            cell.textLabel?.text = support?.description
        case .Delete:
            let delete = DeleteOption(rawValue: indexPath.row)
            cell.textLabel?.text = delete?.description

        }
        
        return cell
    }
    
    //function to see if a row was selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else {return}
        
        //setting up the cells for each of our sections
        switch section{
        case .Account:
            print(AccountOption(rawValue: indexPath.row)?.description)
        case .Support:
            print(SupportOption(rawValue: indexPath.row)?.description)
        case .Delete:
            print(DeleteOption(rawValue: indexPath.row)?.description)
        }
    }
}
