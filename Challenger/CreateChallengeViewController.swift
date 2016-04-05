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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeTextField.inputView = timePicker
    }

}
