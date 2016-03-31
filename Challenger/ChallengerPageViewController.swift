//
//  ChallengerPageViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ChallengePageViewController: UIPageViewController {
    
    static var viewControllerDataSource: [ChallengePrototypeViewController]? {
        var pendingChallengeVCs: [ChallengePrototypeViewController] = []
        if let pendingChallenges = UserController.sharedInstance.currentUser?.pendingChallenges {
            for challenge in pendingChallenges {
                let vc = ChallengePrototypeViewController()
                vc.challenge = challenge
                pendingChallengeVCs.append(vc)
            }
            return pendingChallengeVCs
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = UserController.sharedInstance.currentUser {
            if let firstVC = ChallengePageViewController.viewControllerDataSource?.first {
                self.setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: { (bool) in
                    print("we are inside the setVC completion")
                })

                // how can we get this running?
                // IT COULD BE THAT THIS IS IN VIEWDIDAPPEaR AND IS CALEED TOO OFTEN. MAYBE IT ONLY SHOULD BE CALLED ONCE. WELL WHAT IT A USER SENDS THEM A CHALLENGE? CAN I HANDLE THAT WITHIN THE DATASOURCE FUNCTIONS?
                
                
                print("user has challenges")
            } else {
                // Here would be youre nil case, the case if your current user has no pending challanges.
                print("user has no challenges")
            }
        }
    }
    
}

extension ChallengePageViewController: UIPageViewControllerDataSource {
    
    // In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
    // Return 'nil' to indicate that no more progress can be made in the given direction.
    // For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
    
    // Required Datasource functions
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerDataSource = ChallengePageViewController.viewControllerDataSource else {
            return nil
        }
        
        guard let viewController = viewController as? ChallengePrototypeViewController else {
            return nil
        }
        
        guard let viewControllerIndex = viewControllerDataSource.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllerDataSource.count > previousIndex else {
            return nil
        }
        
        return viewControllerDataSource[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerDataSource = ChallengePageViewController.viewControllerDataSource else {
            return nil
        }
        
        guard let viewController = viewController as? ChallengePrototypeViewController else {
            return nil
        }
        
        // I first need to get the index of the current view Controller. There is one passed into the function as a parameter. That is the one that I need to use.
        guard let viewControllerIndex = viewControllerDataSource.indexOf(viewController) else {
            return nil
        } // If your viewcontroller Datasrouce is using a subclass of UIViewController than you need to cast it as that subclass before this point.
        
        let nextIndex = viewControllerIndex + 1
        
//         Check that the index is valid
        guard nextIndex < viewControllerDataSource.count else {
            return nil
        }
        
        return viewControllerDataSource[1] //with correct index, the index of the viewcontroller after this one. Let's do all the necessary checsk and give it that index.
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








