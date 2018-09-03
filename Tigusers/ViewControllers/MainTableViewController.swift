//
//  MainTableViewController.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    
    // MARK: - Constants & Variables
    
    private var activityIndicator = UIActivityIndicatorView()
    private var fetchedUsers: [UserViewModel]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var link = Config.defaultURL
    
    
    // MARK: - VC life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        
        self.tableView.tableFooterView = UIView()
        setActivityIndicator()
        fetchUsers(link: self.link)
    }
    
    private func fetchUsers(link: String) {
        
        activityIndicator.startAnimating()
        
        Fetch.users(fromURL: link) { [weak self] result in
            switch result {
            case .Success(let users):
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.tableFooterView = nil
                    self?.fetchedUsers = users.map({ return UserViewModel(user: $0) })
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
    
    private func setActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.tableView.backgroundView = activityIndicator
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedUsers?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Config.userCell, for: indexPath) as! UserCell
        
        if let user = fetchedUsers?[indexPath.row] {
            cell.configure(user)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let user = fetchedUsers?[indexPath.row] else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let followersVC = storyboard.instantiateViewController(withIdentifier: Config.mainTVC) as? MainTableViewController {
            followersVC.link = user.followersURL
            self.navigationController?.pushViewController(followersVC, animated: true)
        }
    }
}


// MARK: - Displaying alert message when error occured

extension UIViewController {
    
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

