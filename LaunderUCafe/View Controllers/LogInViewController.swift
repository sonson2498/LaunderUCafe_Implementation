//
//  LogInViewController.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 1/15/21.
//

import UIKit
import Firebase

class LogInViewController: UIViewController{
    
    // iboulets for the fields inside the log in view controller
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elemets
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInButton)
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Username or Password is invalid"
        }
        
        return nil
    }
    
   
    @IBAction func logInTapped(_ sender: Any) {
        
        // validate text fields
        let error = validateFields()
               
        if error != nil {
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            // create cleaned version of the text field
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               
            // signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                   
                if error != nil{
                    // could not sign in
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else{
                    print("Success = \(result!.user.uid)")
                    //transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    // func for showing the error
    func showError(_ message:String) {
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
