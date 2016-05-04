//
//  FirebaseController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import Foundation
import Firebase

class Firebasecontroller {
    static let base = Firebase(url: "https://challenger-dylanslade.firebaseio.com/")
    static let userBase = base.childByAppendingPath("users")
    static let challangeBase = base.childByAppendingPath("challenges")
    static let followingBase = base.childByAppendingPath("following")
    static let followersBase = base.childByAppendingPath("followers")
    
    static func createUser(email: String, password: String, completion: (uid: String?) -> Void) {
        Firebasecontroller.base.createUser(email, password: password) { (error, data) in
            if error != nil {
                print("error while creating user in CreateUser() in Firebasecontroller: \(error)")
                completion(uid: nil)
            } else {
                if let uid = data["uid"] as? String {
                    completion(uid: uid)
                }
            }
        }
    }
    
    static func saveUser(user: User) {
        let uniqueUserRef = userBase.childByAppendingPath(user.uniqueID)
        let userDic: [String: AnyObject] = [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "username": user.username,
            //            "profilePic": user.profilePic,
            ChallengeController.kReceivedChallenges : true,
            ChallengeController.kSentChallenges : true
        ]
        uniqueUserRef.setValue(userDic)
    }
    
    static func dataAtEndpoint(endpoint: String, completion: (data: [String: AnyObject]?) -> Void) {
        Firebasecontroller.base.childByAppendingPath(endpoint).observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if let data = snapshot.value as? [String: AnyObject] {
                completion(data: data)
            } else {
                completion(data: nil)
            }
        })
    }
    
}