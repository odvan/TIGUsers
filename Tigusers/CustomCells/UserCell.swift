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
        
        customizeImageView()
        setOpaqueBackground()
    }

    
    // MARK: - Populating cell with fetched User properties
    
    func configure(_ userModel: User) {
        //print("!!!called")
        avatar.showAvatar(link: userModel.avatar)
        login.text = userModel.login
        profileURL.text = userModel.profileURL
        
    }
    
    // MARK: - CustomImageView tweakings
    
    private func customizeImageView() {
        avatar.layer.cornerRadius = avatar.frame.width/2
        avatar.clipsToBounds = true
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.lightGray.cgColor
    }

}


// MARK: - Setting cell opaque background

private extension UserCell {
    static let defaultBackgroundColor = UIColor.white
    
    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = UserCell.defaultBackgroundColor
        login.alpha = 1.0
        profileURL.alpha = 1.0
        avatar.backgroundColor = UserCell.defaultBackgroundColor
        
    }
}
