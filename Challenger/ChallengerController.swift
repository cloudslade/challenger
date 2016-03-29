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
    private let kText = "text"
    private let kTotalSeconds = "totalSeconds"
    private let kStatus = "status"
    private let kReceiverID = "receiverID"
    private let kSenderId = "senderID"
    
    static let sharedInstance = ChallengeController()
    var allReceivedChallengesForCurrentUser: [Challenge] = []
    var allSentChallengesForUser: [Challenge] = []
    
    static func createSentChallengesForUser() -> [Challenge] {
        var challenges: [Challenge] = []
        if let sentChallengeIDs = UserController.sharedInstance.currentUser?.sentChallenges {
            for challengeID in sentChallengeIDs {
                let endpoint = "challenges/" + "\(challengeID)"
                Firebasecontroller.dataAtEndpoint(endpoint, completion: { (data) in
                    let challange = Challenge(uniqueID: challengeID, json: data)
                    challenges.append(challange)
                })
            }
            return challenges
        }
        return []
    }
    
    static func createReceivedChallengesForUser() -> [Challenge] {
        var challenges: [Challenge] = []
        if let receivedChallengeIDs = UserController.sharedInstance.currentUser?.receivedChallenges {
            for challengeID in receivedChallengeIDs {
                let endpoint = "challenges/" + "\(challengeID)"
                Firebasecontroller.dataAtEndpoint(endpoint, completion: { (data) in
                    let challange = Challenge(uniqueID: challengeID, json: data)
                    challenges.append(challange)
                })
            }
            return challenges
        }
        return []
    }
    
    static func createChallenge(text: String, totalSeconds: NSTimeInterval, senderID: String, receiverID: String, status: ChallengeStatus) {
        let firebaseDic: [String: AnyObject] = [
            ChallengeController.sharedInstance.kText : text,
            ChallengeController.sharedInstance.kTotalSeconds : totalSeconds,
            ChallengeController.sharedInstance.kStatus : status.rawValue,
            ChallengeController.sharedInstance.kReceiverID : receiverID,
            ChallengeController.sharedInstance.kSenderId : senderID
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
    
    func setSentChallengesForUser() {
        ChallengeController.sharedInstance.allSentChallengesForUser = ChallengeController.createSentChallengesForUser()
    }
    
    func setReceivedChallengesForUser() {
        ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser = ChallengeController.createReceivedChallengesForUser()
    }
    
}











