//
//  ProfileViewcontroller.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ChallengeController.createChallenge("Build a hamock", totalSeconds: 543, senderID: "54f41f05-30e5-41b3-838a-5e420401af69", receiverID: "0c84a23a-cf15-4f60-a4ac-686351014b9d", status: .accepted)
    }
}