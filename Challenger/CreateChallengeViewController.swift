//
//  CreateChallengeViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 4/5/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class CreateChallengeViewController: UIViewController {
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var challengeTextView: UITextView!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var timePicker: UIPickerView!
    
    @IBAction func sendChallengeButtonTapped(sender: UIButton) {
        ChallengeController.sharedInstance.createChallenge("Brush your teeth", totalSeconds: 34, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Do twenty pushups", totalSeconds: 20, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("text your mom/dad", totalSeconds: 5, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Read the first chapter of Moby Dick", totalSeconds: 1000, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("delete four emails", totalSeconds: 120, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Ask your crush out", totalSeconds: 360, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Eat a vegetable", totalSeconds: 700, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Thank about what your next big move on life is going to be", totalSeconds: 1040, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        ChallengeController.sharedInstance.createChallenge("Rate this app", totalSeconds: 180, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        
        guard let pvc = self.parentViewController as? ChallengePageViewController else { return }
        if let _ = UserController.sharedInstance.currentUser {
            if let firstVC = pvc.viewControllerDataSource?.first { // Here is the culprit for that bug.
                pvc.setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            } else {
                pvc.setViewControllers([(storyboard?.instantiateViewControllerWithIdentifier("PVCNilCase"))!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
                print("user has no challenges")
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeTextField.inputView = timePicker
    }
    
}
