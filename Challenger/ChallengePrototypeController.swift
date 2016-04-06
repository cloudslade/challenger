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
    @IBOutlet var timerStartedView: UIView!
    @IBOutlet var declinedButtonView: UIView!
    @IBOutlet var goButtonView: UIView!
    @IBOutlet var abortButton: UIButton!
    
    var challenge: Challenge?
    static var delegate: ChallengePrototypeViewControllerdelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateWithChallenge(challenge)
        self.toggleViews()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateOnSecond), name: Timer.notificationSecondTick, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(timerFinished), name: Timer.notificationComplete, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func abortButtonTapped(sender: UIButton) {
        guard let pageViewController = self.parentViewController as? ChallengePageViewController else { return }
        challenge?.timer.stopTimer()
        ChallengeController.sharedInstance.updateReceivedChallengeStatus(challenge!, newStatus: ChallengeStatus.completed)
        if let _ = UserController.sharedInstance.currentUser {
            if let firstVC = pageViewController.viewControllerDataSource?.first { // Here is the culprit for that bug.
                pageViewController.setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            } else {
                pageViewController.setViewControllers([(storyboard?.instantiateViewControllerWithIdentifier("PVCNilCase"))!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
                print("user has no challenges")
            }
        }
        self.toggleViews()
        pageViewController.enablePageTurn()
        ChallengePrototypeViewController.delegate?.enableTabs()
    }
    
    @IBAction func goButtonTapped(sender: UIButton) {
        if let challenge = self.challenge {
            guard let pageViewController = self.parentViewController as? ChallengePageViewController else { return }
            challenge.timer.setTimer(challenge.totalSeconds, totalSeconds: challenge.totalSeconds)
            challenge.timer.startTimer()
            self.toggleViews()
            pageViewController.disablePageTurn()
            ChallengePrototypeViewController.delegate?.disableTabs()
        }
    }
    
    @IBAction func declineButtonTapped(sender: UIButton) {
        guard let pageViewController = self.parentViewController as? ChallengePageViewController else { return }
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
        updateTimerLabel(challenge!.timer.timeString)
    }
    
    func updateTimerLabel(time: String) {
        timerLabel.text = time
    }
    
    @objc func timerFinished() {
        guard let pageViewController = self.parentViewController as? ChallengePageViewController else { return }
        ChallengeController.sharedInstance.updateReceivedChallengeStatus(self.challenge!, newStatus: ChallengeStatus.failed)
        if let _ = UserController.sharedInstance.currentUser {
            if let firstVC = pageViewController.viewControllerDataSource?.first { // Here is the culprit for that bug.
                pageViewController.setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            } else {
                print("user has no challenges")
            }
        }
        self.toggleViews()
        pageViewController.enablePageTurn()
        ChallengePrototypeViewController.delegate?.enableTabs()
    }
    
    func toggleViews() {
        if let challenge = self.challenge {
            if challenge.timer.isOn {
                self.goButtonView.hidden = true
                self.declinedButtonView.hidden = true
                self.timerStartedView.hidden = false
                self.abortButton.hidden = false
            } else {
                self.goButtonView.hidden = false
                self.declinedButtonView.hidden = false
                self.timerStartedView.hidden = true
                self.abortButton.hidden = true
            }
        } else {
            self.goButtonView.hidden = false
            self.declinedButtonView.hidden = false
            self.timerStartedView.hidden = true
            self.abortButton.hidden = true
        }
    }
    
    func formatTime(timeInSeconds: NSTimeInterval) -> String {
        let totalSeconds = Int(timeInSeconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds - (hours * 3600)) / 60
        let seconds = totalSeconds - (hours * 3600) - (minutes * 60)
        var hoursString = ""
        if hours > 0 {
            hoursString = "\(hours):"
        }
        var minutesString = ""
        if minutes < 10 {
            minutesString = "0\(minutes):"
        } else {
            minutesString = "\(minutes):"
        }
        var secondsString = ""
        if seconds < 10 {
            secondsString = "0\(seconds)"
        } else {
            secondsString = "\(seconds)"
        }
        return hoursString + minutesString + secondsString
    }
    
    func updateWithChallenge(challenge: Challenge?) {
        if let challenge = challenge {
            self.challengerTextLabel.text = challenge.text
            self.timerLabel.text = formatTime(challenge.totalSeconds)
            self.declineButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            self.declineButton.backgroundColor = UIColor(colorLiteralRed:0.750, green:0.310, blue:0.345, alpha:1.00)
            self.goButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            self.goButton.backgroundColor = UIColor(colorLiteralRed: 0.114, green: 0.725, blue: 0.329, alpha: 1.00)
        }
    }
    
}

protocol ChallengePrototypeViewControllerdelegate: class {
    func enableTabs()
    func disableTabs()
}




