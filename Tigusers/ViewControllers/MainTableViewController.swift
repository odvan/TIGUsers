//
//  MainTableViewController.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, UISplitViewControllerDelegate {
    
    
    // MARK: - Constants & Variables

    var fetchedUsers: [User]? { // our model
        didSet {
            self.tableView.reloadData()
        }
    }
    var collapseDetailViewController = true
    var rowSelectedAtLeastOnce = false
    

    // MARK: - VC life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = .allVisible

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        if let user = fetchedUsers?[indexPath.row] { // at this point fetchedUsers != nil, could use force unwrap
            cell.configure(user)
        }
        return cell
        
    }
    
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        print(" 💔 💔 💔 ")
        return collapseDetailViewController
    }
    

    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // casual data preparation for sending to FollowersVC
        
        if segue.identifier == Config.followerSegue {
            
            guard fetchedUsers != nil else
            { print("error: no data")
                return }
            
            let user: User
            rowSelectedAtLeastOnce = true
            
            let followerNC = segue.destination as! UINavigationController
            let followerVC = followerNC.topViewController as! FollowerVC
            
            if let indexFirst = sender as? IndexPath {
                user = fetchedUsers![indexFirst.row]
                followerVC.title = "\(user.login) followers"
                followerVC.user = user
                
            } else if let index = self.tableView.indexPathForSelectedRow {
                print("✝️ index \(index)")
                
                user = fetchedUsers![index.row]
                followerVC.title = "\(user.login) followers"
                followerVC.user = user
            }
        }
    }
    
    func firstSegue() { // Show first cell after fetching data in detail VC
        rowSelectedAtLeastOnce = true
        print("It's iPhone Plus in landscape mode or iPad, collapsed: \(splitViewController?.isCollapsed), view bounds:\(view.bounds.height)|\(view.bounds.width)")
        let initialIndexPath = IndexPath(row: 0, section: 0)
        self.tableView.selectRow(at: initialIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
        
        self.performSegue(withIdentifier: Config.followerSegue, sender: initialIndexPath)
        collapseDetailViewController = false
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

