//
//  User.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class User {
    let uniqueID: String
    var username: String
    var profilePic: UIImage?
    var followers: [String] = []
    var following: [String] = []
    var friends: [String] {
        var friends: [String] = []
        for follower in self.followers {
            for following in self.following {
                if follower == following {
                    friends.append(follower)
                    break
                }
            }
        }
        return friends
    }
    var sentChallenges: [String] = []
    var receivedChallenges: [String] = []
    
    // Consider placing the actual objects on the user and
    var pendingChallenges: [Challenge] {
        return ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser.filter({$0.status.rawValue == 0})
    }
    var declinedChallenges: [String] {
        let declinedChallenges = ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser.filter({$0.status.rawValue == 1})
        var declinedUniqueIds: [String] = []
        for challenge in declinedChallenges {
            declinedUniqueIds.append(challenge.uniqueID)
        }
        return declinedUniqueIds
    }
    var acceptedChallenges: [String] {
        let acceptedChallenges = ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser.filter({$0.status.rawValue == 2})
        var acceptedChallengeIDs: [String] = []
        for challenge in acceptedChallenges {
            acceptedChallengeIDs.append(challenge.uniqueID)
        }
        return acceptedChallengeIDs
    }
    var failedChallenges: [String] {
        let failedChallenges = ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser.filter({$0.status.rawValue == 3})
        var failedChallengeIDs: [String] = []
        for challange in failedChallenges {
            failedChallengeIDs.append(challange.uniqueID)
        }
        return failedChallengeIDs
    }
    var completedChallenges: [String] {
        let completedChallenges = ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser.filter({$0.status.rawValue == 4})
        var completedChallengeIDs: [String] = []
        for challenge in completedChallenges {
            completedChallengeIDs.append(challenge.uniqueID)
        }
        return completedChallengeIDs
    }
    
    init(uniqueID: String, username: String, profilePic: UIImage?) {
        self.uniqueID = uniqueID
        self.username = username
        if let profilePic = profilePic {
            self.profilePic = profilePic
        }
    }
    
    init(userJSON: [String: AnyObject], uniqueID: String) {
        self.uniqueID = uniqueID
        self.username = userJSON["username"] as! String
        if let sentChallengesDic = userJSON["sentChallenges"] as? [String: Int] {
            for (challenge, _) in sentChallengesDic {
                sentChallenges.append(challenge)
            }
        }
        if let receivedChallengesDic = userJSON["receivedChallenges"] as? [String: Int] {
            for element in receivedChallengesDic {
                receivedChallenges.append(element.0)
            }
        }
        
    }
    
}






