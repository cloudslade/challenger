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
    
    override func viewDidLoad() {
        self.emailTextField.becomeFirstResponder()
    }
    
    @IBAction func forgotButtonTapped(sender: UIButton) {
        if let email = emailTextField.text {
            Firebasecontroller.base.resetPasswordForUser(email, withCompletionBlock: { error in
                if error != nil {
                    self.errorHandlingLabel.text = "There was an error processing the request"
                } else {
                    self.errorHandlingLabel.text = " Password reset sent successfully"
                }
            })
        } else {
            errorHandlingLabel.text = "Please enter you're email."
        }
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
                    ChallengeController.sharedInstance.setReceivedChallengesForUser ({
                        ChallengeController.sharedInstance.setSentChallengesForUser({
                            self.dismissViewControllerAnimated(true, completion: nil)
                        })
                    })
                })
            }
        })
    }
    
}



