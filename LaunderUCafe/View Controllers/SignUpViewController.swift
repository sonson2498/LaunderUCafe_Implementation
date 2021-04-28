//
//  SignUpViewController.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 1/15/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SwiftUI

class SignUpViewController: UIViewController {

    // iboutlets for all the firelds in the sign up view controller
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
         
         // Hide the error label programatically
         errorLabel.alpha = 0
         
         // Style the elemets (go to utilities to change the style)
         Utilities.styleTextField(firstNameTextField)
         Utilities.styleTextField(lastNameTextField)
         Utilities.styleTextField(emailTextField)
         Utilities.styleTextField(passwordTextField)
         Utilities.styleFilledButton(signupButton)
        
        
     }
    func validateFields() -> String? {
       
       // check that all fields are filled in
       if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
           {
           
           return "Please fill in all fields"
       }
       
       // check if the password is secure
       let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       
       if Utilities.isPasswordValid(cleanedPassword) == false{
           // password is not secure enough
           return "Password must contain at least 8 characters, one number & special character"
       }
       
       return nil
   }


    @IBAction func signUpTapped(_ sender: Any) {
        
        // validate the fields
        let error = validateFields()
               
        if error != nil{
            // There's something wrong with the field show error message
            showError(error!)
        }
        else{
                   
            // create clean version of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   
            // create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            let phoneNumber = ""
            let address = ""
            let city = ""
            let state = ""
            let zipCode = ""
                // check for errors
                if err != nil{
                    // there was an error creating the user
                    self.showError("Error creating user")
                }
                else{
                    // user was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    guard let uid = result?.user.uid else {return} //result!.user.uid
                           
                    db.collection("users").document(uid).setData(["firstName": firstName, "lastName": lastName, "email": email, "uid": uid, "phoneNumber": phoneNumber, "city": city, "address": address, "state": state, "zipCode": zipCode ]) { (error) in
                               
                        if error != nil{
                            // show error message
                            self.showError("Error saving user data")
                        }
                    }
                           
                    // Transition to the home string
                    self.transitionToHome()
                
                }
            }
        }
    }
    // showing the error message when there is an error
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    // function for going to the home screen
    func transitionToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "TabVC")
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
}
