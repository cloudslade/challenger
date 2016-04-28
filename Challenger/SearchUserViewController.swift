//
//  SearchUserViewController.swift
//  Challenger
//
//  Created by Dylan Slade on 3/23/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController, UITableViewDataSource, UserTableViewCellDelegate, UISearchResultsUpdating {
    @IBOutlet var searchBar: UISearchBar!
    var searchUserDataSource: [User] = []
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SearchUserViewController.dismissKeyboards))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @IBOutlet var tableView: UITableView!
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchUserDataSource.count
    }
    
    func dismissKeyboards() {
        self.searchBar.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
        let user = searchUserDataSource[indexPath.row]
        cell.updateWithUser(user)
        cell.delegate = self
        cell.backgroundColor = UIColor.bombGray()
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        UserController.getAllUsers({ (allUsers) in
            if var allUsers = allUsers {
                if let currentUser = UserController.sharedInstance.currentUser {
                    for (index, user) in allUsers.enumerate() {
                        if user.uniqueID == currentUser.uniqueID {
                            allUsers.removeAtIndex(index)
                            self.searchUserDataSource = allUsers
                        }
                    }
                } else {
                    print("No users in the app")
                }
                self.tableView.reloadData()
            }
        })
    }
    
    func buttonTapped(user: User?, completion: () -> Void) {
        if let currentUser = UserController.sharedInstance.currentUser { // being passed by reference
            if let user = user {
                if let index = currentUser.following.indexOf(user.uniqueID) {
                    // unfollow user
                    currentUser.following.removeAtIndex(index)
                    Firebasecontroller.followingBase.childByAppendingPath(currentUser.uniqueID).childByAppendingPath(user.uniqueID).removeValue()
                    Firebasecontroller.followersBase.childByAppendingPath(user.uniqueID).childByAppendingPath(currentUser.uniqueID).removeValue()
                    self.tableView.reloadData()
                    completion()
                } else {
                    // follow user
                    currentUser.following.append(user.uniqueID)
                    Firebasecontroller.followingBase.childByAppendingPath(currentUser.uniqueID).updateChildValues([user.uniqueID: true])
                    Firebasecontroller.followersBase.childByAppendingPath(user.uniqueID).updateChildValues([currentUser.uniqueID: true])
                    self.tableView.reloadData()
                    completion()
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail" {
            if let createChallengeViewController = segue.destinationViewController as? CreateChallengeViewController {
                if let cell = sender as? UserTableViewCell {
                    let indexPath = self.tableView.indexPathForCell(cell)
                    let user = searchUserDataSource[indexPath!.row]
                    createChallengeViewController.user = user
                }
            }
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //
    }
    
}





