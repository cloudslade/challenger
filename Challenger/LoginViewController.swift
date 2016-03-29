//
//  LoginViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit
import Firebase

class LoginVewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorHandlingLabel: UILabel!
    
    @IBAction func forgotButtonTapped(sender: UIButton) {
        // Send the password to the users email.
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Firebasecontroller.base.authUser(email, password: password, withCompletionBlock: { (error, fAuthData) -> Void in
            if error != nil {
                if let errorCode = FAuthenticationError(rawValue: error.code) {
                    switch errorCode {
                    case .UserDoesNotExist:
                        self.errorHandlingLabel.text = "User does not exist"
                        self.errorHandlingLabel.hidden = false
                    case FAuthenticationError.InvalidPassword:
                        self.errorHandlingLabel.text = "Invalid Password"
                        self.errorHandlingLabel.hidden = false
                    case FAuthenticationError.InvalidEmail:
                        self.errorHandlingLabel.text = "Invalid Email"
                        self.errorHandlingLabel.hidden = false
                    default:
                        self.errorHandlingLabel.text = "Unknown Error"
                        self.errorHandlingLabel.hidden = false
                    }
                }
            } else {
                let uniqueUserID = fAuthData.uid
                UserController.getUserForUID(uniqueUserID, completion: { (user) in
                    UserController.sharedInstance.setCurrentUser(user)
                })
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        })
    }
    
}

// Why doesnt the compiler go into the funciton that called it when it is called and own it up.



