//
//  ChallengerController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import Foundation

class ChallengeController {
    static let kReceivedChallenges = "receivedChallenges"
    static let kSentChallenges = "sentChallenges"
    
    static let sharedInstance = ChallengeController()
    var allReceivedChallengesForCurrentUser: [Challenge] = []
    lazy var allSentChallengesForUser: [Challenge] = []
    
    static func allReceivedChallengesForUser(currentUser: User) -> [Challenge] {
        //Here you are going to fetch all of the challenges for the specified user from firebase and convert them into challenges.
        
        let challenges: [Challenge] = []
        return challenges
    }
    
    static func allSentChallengesForUser(currentUser: User) -> [Challenge] {
        return []
    }
    
    static func createChallenge(text: String, totalSeconds: NSTimeInterval, senderID: String, receiverID: String, status: ChallengeStatus) {
        let firebaseDic: [String: AnyObject] = [
            "text" : text,
            "totalSeconds" : totalSeconds,
            "status" : status.rawValue,
            "receiverID" : receiverID,
            "senderID" : senderID
        ]
        Firebasecontroller.challangeBase.childByAutoId().setValue(firebaseDic) { (error, firebase) in
            if let error = error {
                print("error creating Challenge in Firebase(createChallenge() in Challenge Controller): \(error)")
                return
            }
            let challenge = Challenge(uniqueID: firebase.key, text: text, totalSeconds: totalSeconds, senderID: senderID, receiverID: receiverID, status: status)
            Firebasecontroller.userBase.childByAppendingPath(senderID).childByAppendingPath(ChallengeController.kSentChallenges).updateChildValues([firebase.key : status.rawValue])
            Firebasecontroller.userBase.childByAppendingPath(receiverID).childByAppendingPath(ChallengeController.kReceivedChallenges).updateChildValues([firebase.key : status.rawValue])
            if senderID == UserController.sharedInstance.currentUser?.uniqueID {
                ChallengeController.sharedInstance.allSentChallengesForUser.append(challenge)
                UserController.sharedInstance.currentUser?.sentChallenges.append(challenge.uniqueID)
            } else if receiverID == UserController.sharedInstance.currentUser?.uniqueID {
                ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser.append(challenge)
                UserController.sharedInstance.currentUser?.receivedChallenges.append(challenge.uniqueID)
            }
        }
    }
    
    // What shall we do when a user changes the status of a challenge ( decline/accept/fail/complete )
}




// We need to be sure we are appending the the users sent challenges and received challenges ([String]) resepectively when we create a new challenge










