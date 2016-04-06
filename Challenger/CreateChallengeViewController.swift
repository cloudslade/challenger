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
         ChallengeController.sharedInstance.createChallenge("text me", totalSeconds: 5, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
//         ChallengeController.sharedInstance.createChallenge("Read the first chapter of Moby Dick", totalSeconds: 1000, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
//         ChallengeController.sharedInstance.createChallenge("Buy a six pack and come over", totalSeconds: 546, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
//         ChallengeController.sharedInstance.createChallenge("Comb you hair you slob!", totalSeconds: 70, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
//         ChallengeController.sharedInstance.createChallenge("Make me an app", totalSeconds: 10000, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
//         ChallengeController.sharedInstance.createChallenge("Ask Michelle out", totalSeconds: 300, senderID: "35db59b8-4920-4589-99c9-4b81f7d19ff0", receiverID: "546617ea-8664-4e3f-afd4-03427be4d7e9", status: ChallengeStatus.pending)
        
        // Now is time to implement the search functionality
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeTextField.inputView = timePicker
    }

}
