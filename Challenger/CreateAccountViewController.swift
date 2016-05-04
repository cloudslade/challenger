//
//  CreateAccountViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var profilePicButton: UIButton!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var createAccountButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.becomeFirstResponder()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVewController.closeTextInput))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround Large Explosion Iteration 1")!)
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.deregisterFromKeyboardNotifications()
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
    
    
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.placeholder = nil
    }
    
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWasShown), name: "UIKeyboardWillShowNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillBeHidden), name: "UIKeyboardWillHideNotificatin", object: nil)
    }
    
    func deregisterFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UIKeyboardDidHideNotification", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UIKeyboardWillHideNotification", object: nil)
    }
    
    func keyboardWasShown(notification:NSNotification) {
        if let info = notification.userInfo! as? NSDictionary {
            let keyboardSize: CGSize = (info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue().size)!
            let buttonOrigin: CGPoint = self.createAccountButton.frame.origin
            let buttonHeight: CGFloat = self.createAccountButton.frame.size.height
            let pixelsAboveKeyboard: CGFloat = 25
            var visibleRect: CGRect = self.view.frame
            visibleRect.size.height -= keyboardSize.height
            if !CGRectContainsPoint(visibleRect, buttonOrigin) {
                let scrollPoint: CGPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight + pixelsAboveKeyboard)
                self.scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification:NSNotification) {
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.emailTextField {
            self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        } else if textField == self.passwordTextField {
            self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        } else if textField == self.firstNameTextField {
            self.firstNameTextField.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        } else if textField == self.lastNameTextField {
            self.lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        }
    }

    
    
    
    
    
    
    
    
}