//
//  DetailVC.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 3/10/21.
//

import UIKit
import Firebase

class DetailVC: UIViewController {
    
    
    @IBOutlet weak var editingMode: UISwitch!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        getInformation()
        saveButton.isHidden = true
        lastNameTextField.isUserInteractionEnabled = false
        firstNameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        phoneNumberTextField.isUserInteractionEnabled = false
    }
    
    func setUpElements(){
         
         // Hide the error label programatically
         errorLabel.alpha = 0
         
         // Style the elemets (go to utilities to change the style)
         Utilities.styleTextField(firstNameTextField)
         Utilities.styleTextField(lastNameTextField)
         Utilities.styleTextField(emailTextField)
         Utilities.styleTextField(phoneNumberTextField)
         Utilities.styleTextField(addressTextField)
         Utilities.styleTextField(cityTextField)
         Utilities.styleTextField(stateTextField)
         Utilities.styleTextField(zipCodeTextField)
        //design the save button
        Utilities.styleFilledButton(saveButton)
     }
    
    @IBAction func editingModeSwitch(_ sender: Any) {
        lastNameTextField.isUserInteractionEnabled = editingMode.isOn
        firstNameTextField.isUserInteractionEnabled = editingMode.isOn
        emailTextField.isUserInteractionEnabled = editingMode.isOn
        phoneNumberTextField.isUserInteractionEnabled = editingMode.isOn
        
        if editingMode.isOn{
            saveButton.isHidden = false
        }else{
            saveButton.isHidden = true
        }
    }
    
    
    @IBAction func saveMode(_ sender: Any) {
        saveInfo()
    }
    
    func saveInfo(){
        let userEmail = Auth.auth().currentUser?.email
        let currentUser = Auth.auth().currentUser
        
        if lastNameTextField.text != nil && emailTextField.text != nil && phoneNumberTextField != nil {
            db.collection("users").document("\(userID!)").updateData([
                "lastName": lastNameTextField.text!, "email": emailTextField.text!, "firstName": firstNameTextField.text!, "phoneNumber": phoneNumberTextField.text!, "state": stateTextField!,
                "zipCode": zipCodeTextField!, "address": addressTextField!, "city": cityTextField!
            ])
            
            if emailTextField.text != userEmail{
                currentUser?.updateEmail(to: emailTextField.text!){ error in
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
    }
    
    func getInformation(){
        
        db.collection("users").whereField("uid", isEqualTo: userID!).addSnapshotListener{(snap, err) in if err != nil{
            print((err!.localizedDescription))
            return
        }
        
        for i in snap!.documentChanges{
            let firstName = i.document.get("firstName") as! String
            let lastName = i.document.get("lastName") as! String
            let email = i.document.get("email") as! String
            let phoneNumber = i.document.get("phoneNumber") as! String
            let address  = i.document.get("address") as! String
            let city = i.document.get("city") as! String
            let state = i.document.get("state") as! String
            let zipCode = i.document.get("zipCode") as! String
            
            DispatchQueue.main.async {
                self.firstNameTextField.text = "\(firstName)"
                self.lastNameTextField.text = "\(lastName)"
                self.emailTextField.text = "\(email)"
                self.phoneNumberTextField.text = "\(phoneNumber)"
                self.addressTextField.text = "\(address)"
                self.cityTextField.text = "\(city)"
                self.stateTextField.text = "\(state)"
                self.zipCodeTextField.text = "\(zipCode)"
            }
        }
            
        }
    }


}
