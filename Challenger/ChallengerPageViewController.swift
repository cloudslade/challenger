//
//  ChallengerPageViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ChallengePageViewController: UIPageViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        if UserController.sharedInstance.currentUser == nil {
            self.performSegueWithIdentifier("toLoginVC", sender: nil)
        }
    }
    
}