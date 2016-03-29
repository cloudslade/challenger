//
//  UserController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit
import Firebase

class UserController {
    static let sharedInstance = UserController()
    var currentUser: User?
    
    func createUser(username: String, email: String, password: String, profilePic: UIImage?, completion: (user: User) -> Void) {
        Firebasecontroller.createUser(email, password: password) { (uid) in
            var user: User?
            if let uid = uid {
                if let profilePic = profilePic {
                    user = User(uniqueID: uid, username: username, profilePic: profilePic)
                } else {
                    user = User(uniqueID: uid, username: username, profilePic: nil)
                }
            } else {
                print("FireBaseController.createUser is returning nil")
            }
            if let user = user {
                Firebasecontroller.saveUser(user)
                completion(user: user)
            }
        }
    }
    
    func setCurrentUser(user: User) {
        UserController.sharedInstance.currentUser = user
    }
    
    static func getUserForUID(uid: String, completion: (user: User) -> Void) {
        Firebasecontroller.userBase.childByAppendingPath(uid).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if let userDictionary = snapshot.value as? [String: AnyObject] {
                let user = User(json: userDictionary, uniqueID: uid)
                completion(user: user)
            }
        })
    }
    
}