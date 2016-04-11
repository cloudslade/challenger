//
//  CreateChallengeViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 4/5/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class CreateChallengeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var challengeTextView: UITextView!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    //    var seconds = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    //    var minutes = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
    //    var hours = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    var seconds = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    var minutes = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    var hours = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","23"]
    var user: User?
    var selectedSeconds: Int = 0
    var selectedminutes: Int = 0
    var selectedHours: Int = 0
    var timeString: String {
        var formatedHours: String = String(self.selectedHours)
        var formattedMinutes: String = String(self.selectedminutes)
        var formattesSeconds: String = String(self.selectedSeconds)
        if selectedHours < 9 {
            formatedHours = "0\(self.selectedHours)"
        }
        if selectedminutes < 10 {
            formattedMinutes = "0\(self.selectedminutes)"
        }
        if selectedSeconds < 10 {
            formattesSeconds = "0\(self.selectedSeconds)"
        }
            self.timeTextField.text = "\(formatedHours):\(formattedMinutes):\(formattesSeconds)"
            return  "\(formatedHours):\(formattedMinutes):\(formattesSeconds)"
    }
    
    @IBAction func sendChallengeButtonTapped(sender: UIButton) {
        ChallengeController.sharedInstance.createChallenge(challengeTextView.text + " - \(UserController.sharedInstance.currentUser!.username)", totalSeconds: NSTimeInterval(totalSeconds(self.selectedHours, minutes: self.selectedminutes, seconds: self.selectedSeconds)), senderID: UserController.sharedInstance.currentUser!.uniqueID, receiverID: self.user!.uniqueID, status: ChallengeStatus.pending)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user {
            self.updateWithUser(user)
            self.pickerView.dataSource = self
            self.pickerView.delegate = self
        }
        self.timeTextField.inputView = self.pickerView
        self.challengeTextView.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateChallengeViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func totalSeconds(hours: Int, minutes: Int, seconds: Int) -> Int {
        return secondsFromHours(hours) + secondsFromMinutes(minutes) + seconds
    }
    
    func secondsFromHours(hours: Int) -> Int {
        if hours > 0 {
            let minutes = hours * 60
            return minutes * 60
        } else {
            return 0
        }
    }
    
    func secondsFromMinutes(minutes: Int) -> Int {
        if minutes > 0 {
            return minutes * 60
        } else {
            return 0
        }
    }
    
    func dismissKeyboard() {
        challengeTextView.resignFirstResponder()
        timeTextField.resignFirstResponder()
    }
    
    func updateWithUser(user: User) {
        self.usernameLabel.text = user.username
        self.title = user.username
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.hours.count
        } else if component == 1 {
            return self.minutes.count
        } else if component == 2 {
            return self.seconds.count
        } else {
            return 0
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.hours[row] + " hours"
        } else if component == 1 {
            return self.minutes[row] + " min"
        } else if component == 2 {
            return self.seconds[row] + " sec"
        } else {
            return "nothing to display"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.selectedHours = row
            timeString
        } else if component == 1 {
            self.selectedminutes = row
            timeString
        } else if component == 2 {
            self.selectedSeconds = row
            timeString
        }
    }
}




















