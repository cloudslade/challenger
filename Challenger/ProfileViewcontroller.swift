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
    @IBOutlet var completedLabel: UILabel!
    @IBOutlet var failedLabel: UILabel!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var usernameEditButton: UIButton!
    @IBOutlet var passwordEditButton: UIButton!
    @IBOutlet var declinedLabel: UILabel!
    @IBOutlet var acceptedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboards))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround Large Explosion Iteration 1")!)
    }
    
    @IBAction func logoutButtonTapped(sender: UIBarButtonItem) {
        performSegueWithIdentifier("toLogin", sender: nil)
        UserController.sharedInstance.currentUser = nil
    }
    
    @IBAction func editUsernameButtonTapped(sender: UIButton) {
        self.toggleUsername()
    }
    
    @IBAction func editPasswordButtonTapped(sender: UIButton) {
        self.togglePassword()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.updateWithCurrentUser()
        self.navigationController?.navigationBar.barTintColor = UIColor.bombAlphaBlack()
    }
    
    func updateWithCurrentUser() {
        if let currentUser = UserController.sharedInstance.currentUser {
            self.usernameLabel.text = currentUser.username
            self.pendingChallengesLabel.text = "\(currentUser.pendingChallenges.count) pending challenges"
            self.completedLabel.text = "\(currentUser.completedChallenges.count) completed challenges"
            self.failedLabel.text = "\(currentUser.failedChallenges.count) failed challenges"
            self.declinedLabel.text = "\(currentUser.declinedChallenges.count) declined challenges"
            self.acceptedLabel.text = "\(currentUser.failedChallenges.count + currentUser.completedChallenges.count) accepted challenges"
        }
    }
    
    func toggleUsername() {
        if self.usernameLabel.hidden == false {
            self.usernameLabel.hidden = true
            self.usernameTextField.hidden = false
            self.usernameEditButton.setTitle("Save", forState: .Normal)
        } else {
            self.usernameLabel.hidden = false
            self.usernameTextField.hidden = true
            self.usernameEditButton.setTitle("Edit", forState: UIControlState.Normal)
        }
    }
    
    func togglePassword() {
        if self.passwordLabel.hidden == false {
            self.passwordLabel.hidden = true
            self.passwordTextField.hidden = false
            self.passwordEditButton.setTitle("Save", forState: UIControlState.Normal)
        } else {
            self.passwordLabel.hidden = false
            self.passwordTextField.hidden = true
            self.passwordEditButton.setTitle("Edit", forState: UIControlState.Normal)
        }
    }
    
    func dismissKeyboards() {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
}