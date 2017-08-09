//
//  UserCell.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    
    @IBOutlet weak var avatar: CustomImageView!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var profileURL: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK: - Populating cell with fetched User properties
    
    func configure(_ userModel: User) {
        print("!!!!!called")
        avatar.showAvatar(link: userModel.avatar)
        login.text = userModel.login
        profileURL.text = userModel.profileURL
        
    }


}
