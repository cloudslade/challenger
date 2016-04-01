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
    
    // needs testing
    func followUser(userID: String) {
        if let currentUser = UserController.sharedInstance.currentUser {
            currentUser.following.append(userID)
            Firebasecontroller.followingBase.childByAppendingPath(currentUser.uniqueID).updateChildValues([userID: true])
            UserController.getUserForUID(userID) { (user) in
                user.followers.append(currentUser.uniqueID) // this is superfluous as you won't need this initialized object
                Firebasecontroller.followersBase.childByAppendingPath(user.uniqueID).updateChildValues([currentUser.uniqueID: true])
            }
        }
    }
    
    // needs testing
    func unfollowUser(userID: String) {
        if let currentUser = UserController.sharedInstance.currentUser {
            if let followingIndex = currentUser.following.indexOf(userID) {
                currentUser.following.removeAtIndex(followingIndex)
                Firebasecontroller.followingBase.childByAppendingPath(currentUser.uniqueID).childByAppendingPath(userID).removeValue()
            } else {
                print("unfollowUser could not find the index of the user in currentUser following array")
            }
            UserController.getUserForUID(userID, completion: { (user) in
                Firebasecontroller.followersBase.childByAppendingPath(user.uniqueID).childByAppendingPath(currentUser.uniqueID).removeValue()
            })
        }
    }
    
    // needs testing
    static func getAllUsers(completion: (allUsers: [User]?) -> Void) {
        let endpoint = "users"
        var arrayOfAllUsers: [User] = []
        Firebasecontroller.dataAtEndpoint(endpoint) { (data) in
            for (userID, userDic) in data {
                let user = User(json: userDic as! [String : AnyObject], uniqueID: userID)
                arrayOfAllUsers.append(user)
                completion(allUsers: arrayOfAllUsers)
            }
        }
    }
    
}


// get all users in the app
// modify initializer to init with their following and followers
// We will need to create a function that queries firebase for all of the users usernames based on the current thext in the search textfield




