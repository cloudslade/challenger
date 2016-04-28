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
    @IBOutlet var privacyPolicyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.becomeFirstResponder()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround Large Explosion Iteration 1")!)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVewController.closeTextInput))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.privacyPolicyButton.alpha = 0.7
    }
    
    func closeTextInput() {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
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
                    if let user = user {
                        UserController.sharedInstance.setCurrentUser(user)
                        ChallengeController.sharedInstance.setReceivedChallengesForUser ({
                             ChallengeController.sharedInstance.setSentChallengesForUser({
                                UserController.getFollowingForUser(uniqueUserID, completion: { (following) in
                                    UserController.getFollowersForUser(uniqueUserID, completion: { (followers) in
                                        UserController.sharedInstance.currentUser?.following = following
                                        UserController.sharedInstance.currentUser?.followers = followers
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    })
                                })
                            })
                        })
                    }
                })
            }
        })
    }
    
}



