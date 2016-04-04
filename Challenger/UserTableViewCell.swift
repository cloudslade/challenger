//
//  UserTableViewCell.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet var profilePicImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var followButton: UIButton!
    var user: User?
    weak var delegate: UserTableViewCellDelegate?
    
    func updateWithUser(user: User) {
        self.user = user
        self.usernameLabel.text = user.username
        if let _ = user.profilePic {
            
        } else {
            self.profilePicImageView.image = UIImage(named: "profileDefault")
        }
        if UserController.sharedInstance.currentUser?.following.indexOf(user.uniqueID) == nil {
            self.followButton.setTitle("Follow", forState: UIControlState.Normal)
//            self.followButton.backgroundColor = UIColor(colorLiteralRed: 0.114, green: 0.725, blue: 0.329, alpha: 1.00)
//            self.followButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        } else {
            self.followButton.setTitle("Unfollow", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func followButtonTapped(sender: UIButton) {
        delegate?.buttonTapped(user, completion: {
        })
    }
    
}

protocol UserTableViewCellDelegate: class {
    func buttonTapped(user: User?, completion: () -> Void)
}