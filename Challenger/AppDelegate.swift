//
//  AppDelegate.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //Firebase.defaultConfig().persistenceEnabled = true
//        AppearanceController.initializeAppearance()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
    
}

// Consider giving users an initial challange to follow a friend and send a challenge in x amount of time.
// When the user finishes their last challenge the app doesnt remove the viewController. Fix this
// Allow the user to navigate through the tab bar and come back to their accepted challenge
// Allow the user to create challenges and return the their accepted challenge
    // What if the challenge finished while they are on a seperate tab. You would need a case for that as well

// get any followed or following users to show up while the user types their name

// Create an app. You can recycle most of the code from here, that will allow users to post things/ challenges they need completed and users that are bored cna have those challenges sent to them.

// If you try to constrain a stack view and cause it to strech there will be one element that stretches to meet the constraint you have it. It could be one button that is really large.