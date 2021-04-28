//
//  ContactUs_VC.swift
//  LaunderUCafe
//
//  Created by Veridson Felissaint on 4/14/21.
//

import UIKit
import MessageUI

class ContactUs_VC: UIViewController,MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
         
         // Hide the error label programatically
         //errorLabel.alpha = 0
         
         // Style the elemets (go to utilities to change the style)
         Utilities.styleTextField(nameField)
         Utilities.styleTextField(emailField)
         Utilities.styleTextField(messageField)
         //design the save button
         Utilities.styleFilledButton(sendButton)
    }
    
    
    @IBAction func send(_ sender: Any) {
        
        let toRecipients = ["launderucafe@gmail.com"]
        
        let mc = MFMailComposeViewController()
        
        mc.mailComposeDelegate = self
        
        mc.setToRecipients(toRecipients)
        mc.setSubject("Concern From \(nameField.text!)")
        mc.setMessageBody("Name: \(String(describing: nameField.text)) \n\nEmail: \(String(describing: emailField.text)) \n\nMessage: \(messageField.text!)", isHTML: false)
        
        self.present(mc, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           if let _ = error {
               controller.dismiss(animated: true, completion: nil)
               return
           }
           switch result {
           case .cancelled:
               break
           case .failed:
               break
           case .saved:
               break
           case .sent:
               break
           @unknown default:
            break
           }
           controller.dismiss(animated: true, completion: nil)
       }
    
    
    
    
    
    
    
    
    // dismiss the keyboard if the user press a stupid button (use for lower iOS devices)
    @IBAction func dismissKeyboard(_ sender: Any) {
        
        self.resignFirstResponder()
    }
    
}
