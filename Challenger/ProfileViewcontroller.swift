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
        ChallengeController.sharedInstance.setSentChallengesForUser() {
            print(UserController.sharedInstance.currentUser?.sentChallenges)
            let sentChallengeCount = ChallengeController.sharedInstance.allSentChallengesForUser.count
            self.pendingChallengesLabel.text = String(sentChallengeCount) + " Sent"
        }
//        ChallengeController.createSentChallengesForCurrentUser { (challenges) in
//                print(challenges)
//        }
        
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        // clear all data source in the app
        // segue to the login screen
    }
    
}