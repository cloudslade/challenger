//
//  ProfileViewcontroller.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var pendingChallengesLabel: UILabel!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        performSegueWithIdentifier("toLogin", sender: nil)
        UserController.sharedInstance.currentUser = nil
    }
    
    @IBAction func editUsernameButtonTapped(sender: UIButton) {
        self.toggleUsername()
    }
    
    @IBAction func editPasswordButtonTapped(sender: UIButton) {
        self.togglePassword()
    }
    
    func toggleUsername() {
        if self.usernameLabel.hidden == false {
            self.usernameLabel.hidden = true
            self.usernameTextField.hidden = false
        } else {
            self.usernameLabel.hidden = false
            self.usernameTextField.hidden = true
        }
    }
    
    func togglePassword() {
        if self.passwordLabel.hidden == false {
            self.passwordLabel.hidden = true
            self.passwordTextField.hidden = false
        } else {
            self.passwordLabel.hidden = false
            self.passwordTextField.hidden = true
        }
    }
}