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
    
    static func getUserForUID(uid: String, completion: (user: User?) -> Void) {
        Firebasecontroller.dataAtEndpoint("users/\(uid)", completion: { (data) in
            if let data = data {
                let user = User(userJSON: data, uniqueID: uid)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        })
    }
    
    static func getFollowingForUser(userID: String, completion: (following: [String]) -> Void) {
        Firebasecontroller.dataAtEndpoint("following/\(userID)", completion: { (data) in
            if let data = data {
                var following: [String] = []
                for (userID, _) in data {
                    following.append(userID)
                }
                completion(following: following)
            } else {
                completion(following: [])
            }
        })
    }
    
    static func getFollowersForUser(userID: String, completion: (followers: [String]) -> Void) {
        Firebasecontroller.dataAtEndpoint("followers/\(userID)", completion: { (data) in
            if let data = data {
                var followers: [String] = []
                for (userID, _) in data {
                    followers.append(userID)
                }
                completion(followers: followers)
            } else {
                completion(followers: [])
            }
        })
    }
    
    // needs testing
    func followUser(userID: String) {
        if let currentUser = UserController.sharedInstance.currentUser {
            currentUser.following.append(userID)
            Firebasecontroller.followingBase.childByAppendingPath(currentUser.uniqueID).updateChildValues([userID: true])
            UserController.getUserForUID(userID) { (user) in
                if let user = user {
                    user.followers.append(currentUser.uniqueID) // this is superfluous as you won't need this initialized object
                    Firebasecontroller.followersBase.childByAppendingPath(user.uniqueID).updateChildValues([currentUser.uniqueID: true])
                }
            }
        }
    }
    
    // needs testing
    func unfollowUser(userID: String) {
        if let currentUser = UserController.sharedInstance.currentUser {
            if let followingIndex = currentUser.following.indexOf(userID) {
                currentUser.following.removeAtIndex(followingIndex)
                Firebasecontroller.followingBase.childByAppendingPath(currentUser.uniqueID).childByAppendingPath(userID).removeValue()
                Firebasecontroller.followersBase.childByAppendingPath(userID).childByAppendingPath(currentUser.uniqueID).removeValue()
            } else {
                print("unfollowUser could not find the index of the user in currentUser following array")
            }
        }
    }
    
    // needs testing
    static func getAllUsers(completion: (allUsers: [User]?) -> Void) {
        let endpoint = "users"
        var arrayOfAllUsers: [User] = []
        Firebasecontroller.dataAtEndpoint(endpoint) { (data) in
            for (userID, userDic) in data! {
                let user = User(userJSON: userDic as! [String : AnyObject], uniqueID: userID)
                arrayOfAllUsers.append(user)
            }
            completion(allUsers: arrayOfAllUsers)
        }
    }
    
}


// get all users in the app
// modify initializer to init with their following and followers
// We will need to create a function that queries firebase for all of the users usernames based on the current thext in the search textfield



// We need to make our user Initializer also initialize with the users followers and following.