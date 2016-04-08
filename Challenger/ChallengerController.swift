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
    
    static func initializeSentChallengesForCurrentUser(completion: (challenges: [Challenge]) -> Void) {
        var challenges: [Challenge] = []
        if let sentChallengeIDs = UserController.sharedInstance.currentUser?.sentChallenges {
            let group = dispatch_group_create()
            for challengeID in sentChallengeIDs {
                dispatch_group_enter(group)
                let endpoint = "challenges/" + "\(challengeID)"
                Firebasecontroller.dataAtEndpoint(endpoint, completion: { (data) in
                    if let data = data {
                        let challange = Challenge(uniqueID: challengeID, json: data)
                        challenges.append(challange)
                        dispatch_group_leave(group)
                    } else {
                        dispatch_group_leave(group)
                    }
                })
            }
            dispatch_group_notify(group, dispatch_get_main_queue(), {
                completion(challenges: challenges)
            })
        } else {
            completion(challenges: [])
        }
    }
    
    static func initializeReceivedChallengesForCurrentUser(completion: (challenges: [Challenge]) -> Void) {
        var challenges: [Challenge] = []
        if let receivedChallengeIDs = UserController.sharedInstance.currentUser?.receivedChallenges {
            let group = dispatch_group_create()
            for challengeID in receivedChallengeIDs {
                dispatch_group_enter(group)
                let endpoint = "challenges/" + "\(challengeID)"
                Firebasecontroller.dataAtEndpoint(endpoint, completion: { (data) in
                    if let data = data {
                        let challange = Challenge(uniqueID: challengeID, json: data)
                        challenges.append(challange)
                        dispatch_group_leave(group)
                    } else {
                        dispatch_group_leave(group)
                    }
                })
            }
            dispatch_group_notify(group, dispatch_get_main_queue(), {
                completion(challenges: challenges)
            })
        } else {
            completion(challenges: challenges)
        }
    }
    
    func createChallenge(text: String, totalSeconds: NSTimeInterval, senderID: String, receiverID: String, status: ChallengeStatus) {
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
    
    func setSentChallengesForUser(completion: () -> Void) {
        ChallengeController.initializeSentChallengesForCurrentUser({ (challenges: [Challenge]) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                ChallengeController.sharedInstance.allSentChallengesForUser = challenges
                completion()
            })
        })
    }
    
    func setReceivedChallengesForUser(completion: () -> Void) {
        ChallengeController.initializeReceivedChallengesForCurrentUser({ (challenges) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser = challenges
                completion()
            })
        })
    }
    
    func updateReceivedChallengeStatus(challenge: Challenge, newStatus: ChallengeStatus) {
        for element in ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser {
            if element == challenge {
                element.status = newStatus
            }
        }
        Firebasecontroller.challangeBase.childByAppendingPath(challenge.uniqueID).childByAppendingPath("status").setValue(newStatus.rawValue)
        Firebasecontroller.userBase.childByAppendingPath(challenge.senderID).childByAppendingPath("sentChallenges").childByAppendingPath(challenge.uniqueID).setValue(newStatus.rawValue)
        Firebasecontroller.userBase.childByAppendingPath(challenge.receiverID).childByAppendingPath("receivedChallenges").childByAppendingPath(challenge.uniqueID).setValue(newStatus.rawValue)
    }
    
    func createInitialChallenges(senderID: String, receiverID: String) {
        ChallengeController.sharedInstance.createChallenge("Welcome to Challenge Bomber! To start the timed challenge tap the 'Go' button. To Complete tap the complete button. -(Dylan)", totalSeconds: 10, senderID: senderID, receiverID: receiverID, status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("When a challenge is in session navigation is locked. -(Dylan)", totalSeconds: 4, senderID: senderID, receiverID: receiverID, status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Send me your thoughts about the app and how I can make it better. Thanks! - (Dylan)", totalSeconds: 1000, senderID: senderID, receiverID: receiverID, status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Do 20 pushups - (Dylan)", totalSeconds: 20, senderID: senderID, receiverID: receiverID, status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Find something that makes you happy. - (Dylan)", totalSeconds: 300, senderID: senderID, receiverID: receiverID, status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Make a paper football. - (Dylan)", totalSeconds: 45, senderID: senderID, receiverID: receiverID, status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Drink an oz of water - (Dylan)", totalSeconds: 400, senderID: senderID, receiverID: receiverID, status: ChallengeStatus.pending)
    }
    
}











