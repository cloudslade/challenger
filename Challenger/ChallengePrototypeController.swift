//
//  ChallengePrototypeController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ChallengePrototypeViewController: UIViewController {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var challengerTextLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var declineButton: UIButton!
    @IBOutlet var goButton: UIButton!
    
    var challenge: Challenge?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.updateWithChallenge(challenge)
    }
    
//    func updateWithChallenge(challenge: Challenge?) {
//        if let challenge = challenge {
//            self.challengerTextLabel.text = challenge.text
//            self.timerLabel.text = String(challenge.totalSeconds)
//        }
//    }
    
}