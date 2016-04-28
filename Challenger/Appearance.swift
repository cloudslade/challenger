//
//  Appearance.swift
//  Challenger
//
//  Created by Dylan Slade on 4/7/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class AppearanceController {
    static func initializeAppearance() {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UINavigationBar.appearance().tintColor = UIColor.bombOrange()
        UINavigationBar.appearance().barTintColor = UIColor.bombAlphaBlack()
        UITabBar.appearance().barTintColor = UIColor.bombAlphaBlack()
        UITabBar.appearance().tintColor = UIColor.bombRed()
        UIButton.appearance().tintColor = UIColor.bombYellow()
        UITextField.appearance().backgroundColor = UIColor.bombGray()
        UITextField.appearance().tintColor = UIColor.bombYellow()
        UILabel.appearanceWhenContainedInInstancesOfClasses([UITextField.self]).textColor = UIColor.whiteColor()
    }
}

extension UIColor {
    static func bombGray() -> UIColor {
        return UIColor(colorLiteralRed:0.518, green:0.518, blue:0.518, alpha:1.00)
    }
    
    static func bombYellow() -> UIColor {
        return UIColor(colorLiteralRed:0.965, green:0.733, blue:0.141, alpha:1.00)
    }
    
    static func bombOrange() -> UIColor {
        return UIColor(colorLiteralRed:0.965, green:0.349, blue:0.141, alpha:1.00)
    }
    
    static func bombRed() -> UIColor {
        return UIColor(colorLiteralRed:0.859, green:0.208, blue:0.098, alpha:1.00)
    }
    
    static func bombAlphaBlack() -> UIColor {
        return UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    }
    
}