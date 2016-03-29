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
    
    static func createSentChallengesForCurrentUser(completion: (challenges: [Challenge]) -> Void) {
        var challenges: [Challenge] = []
        if let sentChallengeIDs = UserController.sharedInstance.currentUser?.sentChallenges {
            let group = dispatch_group_create()
            for challengeID in sentChallengeIDs {
                dispatch_group_enter(group)
                let endpoint = "challenges/" + "\(challengeID)"
                Firebasecontroller.dataAtEndpoint(endpoint, completion: { (data) in
                    let challange = Challenge(uniqueID: challengeID, json: data)
                    challenges.append(challange)
                    dispatch_group_leave(group)
                })
            }
            dispatch_group_notify(group, dispatch_get_main_queue(), { 
                completion(challenges: challenges)
            })
        } else {
            completion(challenges: [])
        }
    }
    
    static func createReceivedChallengesForCurrentUser() -> [Challenge] {
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
    
    func setSentChallengesForUser(completion: ()->Void) {
        ChallengeController.createSentChallengesForCurrentUser({ (challenges: [Challenge]) -> Void in
            dispatch_async(dispatch_get_main_queue(), { 
                ChallengeController.sharedInstance.allSentChallengesForUser = challenges
                completion()
            })
        })
    }
    
    func setReceivedChallengesForUser() {
        ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser = ChallengeController.createReceivedChallengesForCurrentUser()
    }
    
}











