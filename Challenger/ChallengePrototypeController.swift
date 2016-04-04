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
        self.updateWithChallenge(challenge)
    }
    
    func updateWithChallenge(challenge: Challenge?) {
        if let challenge = challenge {
            self.challengerTextLabel.text = challenge.text
            self.timerLabel.text = String(challenge.totalSeconds)
            self.declineButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            self.declineButton.backgroundColor = UIColor(colorLiteralRed:0.750, green:0.310, blue:0.345, alpha:1.00)
            self.goButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            self.goButton.backgroundColor = UIColor(colorLiteralRed: 0.114, green: 0.725, blue: 0.329, alpha: 1.00)
        }
    }
    
}