//
//  Challenger.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import Foundation

class Challenge {
    let uniqueID: String
    var text: String
    var timer: NSTimer?
    var totalSeconds: NSTimeInterval
    let senderID: String
    let receiverID: String
    var status: ChallengeStatus
    
    init(uniqueID: String, text: String, totalSeconds: NSTimeInterval, senderID: String, receiverID: String, status: ChallengeStatus) {
        self.uniqueID = uniqueID
        self.text = text
        self.totalSeconds = totalSeconds
        self.senderID = senderID
        self.receiverID = receiverID
        self.status = status
    }
    
}

enum ChallengeStatus: Int {
    case pending
    case declined, accepted
    case failed, completed
}