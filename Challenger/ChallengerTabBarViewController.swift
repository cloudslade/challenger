//
//  ChallengerTabBarViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/30/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ChallengerTabBarViewController: UITabBarController, ChallengePrototypeViewControllerdelegate {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if UserController.sharedInstance.currentUser == nil {
            self.performSegueWithIdentifier("toLoginVC", sender: nil)
        }
        self.selectedIndex = 1
        
        ChallengePrototypeViewController.delegate = self
    }
    
    func disableTabs() {
        self.tabBar.userInteractionEnabled = false
        // grey the images on the tab bar so the suer knows they canont click on anything.
    }
    
    func enableTabs() {
        self.tabBar.userInteractionEnabled = true
        // grey the images on the tab bar so the suer knows they canont click on anything.
    }
}