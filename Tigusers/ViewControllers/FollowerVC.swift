//
//  FollowerVC.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import UIKit

class FollowerVC: UIViewController {
    

    // MARK: - Constants & Variables

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var user: User?
    var userFollowers: [User]? {
        didSet {
           updateFollowersLabel()
        }
    }
    @IBOutlet weak var pageWithFollowersNumber: UILabel!
    @IBOutlet weak var textViewWithFollowers: UITextView!
    var number = 1
    
   
    // MARK: - VC life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
        
        if user != nil {
            fetchFollowers(page: number)
        }
    }
    
    
    // MARK: - Main method for fetching followers (exactly like for users, only different link)
    
    private func fetchFollowers(page: Int) {
        
        guard user?.followersURL != nil, !String(page).isEmpty
            else { return }
        let url = user!.followersURL + String(page)
        
        Fetch.users(fromURL: url) { [weak self] result in
            
            switch result {
            case .Success(let users):
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self?.activityIndicator.stopAnimating()
                    if !users.isEmpty { // in case no more pages with followers or no followers
                        self?.userFollowers = users
                    } else {
                        self?.previousPageWithFollowers(nil)
                    }
                }
                
            case .Error(let message):
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self?.activityIndicator.stopAnimating()
                    self?.showAlertWith(title: "Error", message: message)
                }
            }
        }

    }
    
    
    // MARK: - Updating textView with User's followers
    
    private func updateFollowersLabel() {
        var followersForLabel: String = ""
        for follower in userFollowers! {
            followersForLabel += follower.login + ", "
        }
        textViewWithFollowers.isHidden = false
        followersForLabel.characters.removeLast(2)
        textViewWithFollowers.text = followersForLabel
    }
    
    
    // MARK: - Button with methods to show next/previous page of the followers
    
    @IBAction func previousPageWithFollowers(_ sender: UIButton?) {
        number -= 1
        guard number >= 1 else { number += 1
            return }
        
        pageWithFollowersNumber.text = String(number)
        fetchFollowers(page: number)
    }
    @IBAction func nextPageWithFollowers(_ sender: UIButton?) {
        number += 1
        guard number >= 1 else { return }
        pageWithFollowersNumber.text = String(number)
        fetchFollowers(page: number)
    }
    

}
