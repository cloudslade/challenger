//
//  SearchUserViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {
    
    override func viewDidLoad() {
        ChallengeController.sharedInstance.setReceivedChallengesForUser { 
            ChallengeController.sharedInstance.setSentChallengesForUser({
                print("loaded received and sent challanges for current user")
            })
        }
    }
}