//
//  ChallengerController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import Foundation

class ChallengeController {
    static let sharedInstance = ChallengeController()
    var allChallengesForCurrentUser: [Challenge] = []
    
    static func allChallengesForUser(currentUser: User) -> [Challenge] {
        //Here you are going to fetch all of the challenges from firease and convert them into challenges.
        
        let challenges: [Challenge] = []
        return challenges
    }
    
    
}