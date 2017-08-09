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

    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var user: User?
    var userFollowers: [User]? {
        didSet {
           updateFollowersLabel()
        }
    }
    
    
    // MARK: - VC life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
        
        if let someUser = user {
            Fetch.users(fromURL: someUser.followersURL) { [weak self] result in
                
                switch result {
                case .Success(let users):
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        self?.activityIndicator.stopAnimating()
                        self?.userFollowers = users
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
    }
    
    
    // MARK: - Updating label with User's followers
    
    private func updateFollowersLabel() {
        var followersForLabel: String = ""
        for follower in userFollowers! {
            followersForLabel += follower.login + ", "
        }
        followersForLabel.characters.removeLast(2)
        followers.text = followersForLabel
    }

}
