//
//  ChallengerPageViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ChallengePageViewController: UIPageViewController, ChallengePrototypeViewControllerParent {
    
    var viewControllerDataSource: [ChallengePrototypeViewController]? {
        var pendingChallengeVCs: [ChallengePrototypeViewController] = []
        if let pendingChallenges = UserController.sharedInstance.currentUser?.pendingChallenges {
            for challenge in pendingChallenges {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChallengeVC")
                    as! ChallengePrototypeViewController
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
        delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = UserController.sharedInstance.currentUser {
            if let firstVC = viewControllerDataSource?.first {
                self.setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            } else {
                // add a nil case here
                print("user has no challenges")
            }
        }
    }
    
    func disableScrolling() {
        for view in self.view.subviews {
            if view.isKindOfClass(UIScrollView) {
                if let view = view as? UIScrollView {
                    view.scrollEnabled = false
                }
            }
        }
    }
    
    func enableScrolling() {
        for view in self.view.subviews {
            if view.isKindOfClass(UIScrollView) {
                if let view = view as? UIScrollView {
                    view.scrollEnabled = true
                }
            }
        }
    }
    
}

extension ChallengePageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        print("IS GOING TO TRANSITION")
    }
    
    // MARK: - Required Datasource functions
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerDataSource = viewControllerDataSource else {
            return nil
        }
        guard let viewController = viewController as? ChallengePrototypeViewController else {
            return nil
        }
        guard let currentIndex = UserController.sharedInstance.currentUser?.pendingChallenges.indexOf({$0 == viewController.challenge!}) else {
            return nil
        }
        guard currentIndex > 0 else {
            return nil
        }
        guard viewControllerDataSource.count > currentIndex else {
            return nil
        }
        return viewControllerDataSource[currentIndex - 1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerDataSource = viewControllerDataSource else {
            return nil
        }
        guard let viewController = viewController as? ChallengePrototypeViewController else {
            return nil
        }
        guard let currentIndex = UserController.sharedInstance.currentUser?.pendingChallenges.indexOf({$0 == viewController.challenge!}) else {
            return nil
        }
        let nextIndex = currentIndex + 1
        guard nextIndex < viewControllerDataSource.count else {
            return nil
        }
        return viewControllerDataSource[nextIndex] // with correct index, the index of the viewcontroller after this one. Let's do all the necessary checsk and give it that index.
    }
    
    // MARK: - Optional Datasource functions
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }// The number of items reflected in the page indicator.
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2
    }// The selected item reflected in the page indicator.
    
    
    // MARK: - Challenge ViewController Delegate
    
    func declineButtonTapped() {
        // update the pageViewController
        if let _ = UserController.sharedInstance.currentUser {
            if let firstVC = viewControllerDataSource?.first {
                self.setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            } else {
                print("user has no challenges")
            }
        }
    }
    
    func goButtonTapped() {
        
    }
    
    
}







