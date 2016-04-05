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
    
    var timer = Timer()
    
    var challenge: Challenge?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateWithChallenge(challenge)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateOnSecond), name: Timer.notificationSecondTick, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(timerFinished), name: Timer.notificationComplete, object: nil)
    }
    
    @IBAction func goButtonTapped(sender: UIButton) {
        // start timer. Lock views
        if let challenge = self.challenge {
            guard let pageViewController = self.parentViewController as? ChallengePageViewController else {return}
            timer.setTimer(challenge.totalSeconds, totalSeconds: challenge.totalSeconds)
            timer.startTimer()
            pageViewController.goButtonTapped()
        }
    }
    
    @IBAction func declineButtonTapped(sender: UIButton) {
        guard let pageViewController = self.parentViewController as? ChallengePageViewController else {return}
        for challenge in ChallengeController.sharedInstance.allReceivedChallengesForCurrentUser {
            if challenge == self.challenge! {
                challenge.status = ChallengeStatus.declined
                Firebasecontroller.challangeBase.childByAppendingPath(challenge.uniqueID).childByAppendingPath("status").setValue(1)
                Firebasecontroller.userBase.childByAppendingPath(challenge.senderID).childByAppendingPath("sentChallenges").childByAppendingPath(challenge.uniqueID).setValue(1)
                Firebasecontroller.userBase.childByAppendingPath(challenge.receiverID).childByAppendingPath("receivedChallenges").childByAppendingPath(challenge.uniqueID).setValue(1)
            }
        }
        pageViewController.declineButtonTapped()
    }
    
    @objc func updateOnSecond() {
        updateTimerLabel(timer.timeString)
    }
    
    func updateTimerLabel(time: String) {
        timerLabel.text = time
    }
    
    @objc func timerFinished() {
        guard let pageViewController = self.parentViewController as? ChallengePageViewController else { return }
        pageViewController.enableScrolling()
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

protocol ChallengePrototypeViewControllerParent {
    func declineButtonTapped()
    func goButtonTapped()
}