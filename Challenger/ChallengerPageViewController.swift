//
//  ChallengerPageViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ChallengePageViewController: UIPageViewController {
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)// We are using viewWillAppear becaues we don't want the
//        guard let _ = UserController.sharedInstance.currentUser else {
//            self.tabBarController?.performSegueWithIdentifier("toLoginVC", sender: nil)
//            return
//        }
//    }
    override func viewDidAppear(animated: Bool) {
        if UserController.sharedInstance.currentUser == nil {
            self.performSegueWithIdentifier("toLoginVC", sender: nil)
        }
//        UserController.sharedInstance.createUser("johnnyboy", email: "yola@gmail.com", password: "1234", profilePic: nil)
//        UserController.sharedInstance.createUser("SallyMay", email: "SallyMay@yahoo.com", password: "123", profilePic: nil)
    }
}