//
//  CreateAccountViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet var profilePicButton: UIButton!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func createAccountButtonTapped(sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        UserController.sharedInstance.createUser(username, email: email, password: password, profilePic: nil, completion: { (user) -> Void in
            UserController.sharedInstance.setCurrentUser(user)
            self.navigationController?.navigationBarHidden = true
            self.performSegueWithIdentifier("toBeginAgain", sender: nil)
        })
        
    }
    
    @IBAction func profilePicButtonTapped(sender: UIButton) {
        
    }
    
}