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
        ChallengeController.createChallenge("Build a hamock", totalSeconds: 543, senderID: "b3ccf8bf-63d9-4eb1-934d-84406cc7933f", receiverID: "edbd9769-3d38-4427-a8cc-a514215c97a0", status: .accepted)
    }
}