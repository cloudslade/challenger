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
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.becomeFirstResponder()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVewController.closeTextInput))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func closeTextInput() {
        self.usernameTextField.resignFirstResponder()
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @IBAction func createAccountButtonTapped(sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        
        UserController.sharedInstance.createUser(username, email: email, firstName: firstName, lastName: lastName, password: password, profilePic: nil, completion: { (user) -> Void in
            UserController.sharedInstance.setCurrentUser(user)
            ChallengeController.sharedInstance.createInitialChallenges("48e89609-c4e0-4362-abf3-efe6ad85ebe4", receiverID: user.uniqueID)
            self.navigationController?.navigationBarHidden = true
            self.performSegueWithIdentifier("toBeginAgain", sender: nil)
        })
    }
    
    @IBAction func profilePicButtonTapped(sender: UIButton) {
        
    }
    
}