//
//  FetchingUsersVC.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import UIKit


class FetchingUsersVC: MainTableViewController { // subclassed MainTableViewController for more structured and cleaner code

    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundView = activityIndicator
        mainFetchMethod()
    }

    
    // MARK: - Wrapping main method for fetching users
    
    private func mainFetchMethod() {
        
        activityIndicator.startAnimating()
        
        Fetch.users(fromURL: Config.defaultURL) { [weak self] result in

            switch result {
            case .Success(let users):
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.tableFooterView = nil
                    self?.fetchedUsers = users
                    print("\(self?.view.frame.size.width), collapsed: \(self?.splitViewController?.isCollapsed)")
                    if self?.view.frame.size.height == 414 || UIDevice.current.userInterfaceIdiom == .pad { // firing segue to first currency cell after fetching data
                        self?.firstSegue()
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

}
