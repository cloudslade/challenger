//
//  ChallengerTabBarViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/30/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ChallengerTabBarViewController: UITabBarController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if UserController.sharedInstance.currentUser == nil {
            self.performSegueWithIdentifier("toLoginVC", sender: nil)
        }
        self.selectedIndex = 1
    }
    
}
