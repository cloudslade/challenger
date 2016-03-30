//
//  ChallengerPageViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ChallengePageViewController: UIPageViewController {
    
    var viewControllerDataSource: [ChallengePrototypeViewController]? {
        var pendingChallengeVCs: [ChallengePrototypeViewController] = []
        if let pendingChallenges = UserController.sharedInstance.currentUser?.pendingChallenges {
            for challenge in pendingChallenges {
                let vc: ChallengePrototypeViewController = ChallengePrototypeViewController()
                vc.challengerTextLabel.text = challenge.text // Why am I finding nil while unwrapping this?
                pendingChallengeVCs.append(vc)
            }
            return pendingChallengeVCs
        }
        return nil
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        dataSource = self
        if UserController.sharedInstance.currentUser == nil {
            self.performSegueWithIdentifier("toLoginVC", sender: nil)
        }
        print(viewControllerDataSource)
    }
    
    
}

extension ChallengePageViewController: UIPageViewControllerDataSource {
    
    // In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
    // Return 'nil' to indicate that no more progress can be made in the given direction.
    // For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
    
    // Required Datasource functions
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChallengeVC")
    }
    
    // A page indicator will be visible if both methods are implemented, transition style is 'UIPageViewControllerTransitionStyleScroll', and navigation orientation is 'UIPageViewControllerNavigationOrientationHorizontal'.
    // Both methods are called in response to a 'setViewControllers:...' call, but the presentation index is updated automatically in the case of gesture-driven navigation.
    
    
    // Optional Datasource functions
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }// The number of items reflected in the page indicator.
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2
    }// The selected item reflected in the page indicator.
    
    
    
}

// Well Today I will be spending most of my time using pageViewControllers.
// 1. Get a single page to display on the screen.
// 2. User mock data to swipe through pages.








