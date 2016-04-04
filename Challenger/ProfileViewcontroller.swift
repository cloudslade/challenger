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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        performSegueWithIdentifier("toLogin", sender: nil)
        UserController.sharedInstance.currentUser = nil
    }
    
}