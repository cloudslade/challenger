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

// When you get your challange ID's working be sure to update your
// I need a function in my Firebase Controller that I can use to retrieve data at a specific endpoint.
// Do all lines of execution have segments of execution inside of them

// Completions are used oftimes because the program is just running and if you have something that takes time to execute the program will just skip it until it is called while it continues executing.

