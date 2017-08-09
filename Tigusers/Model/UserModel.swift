//
//  UserModel.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import Foundation


struct User {
    
    let login: String
    let id: String
    let avatar: String
    let profileURL: String
    let followersURL: String
    
    init(login: String, id: String, avatar: String, profileURL: String, followersURL: String) {
        
        self.login = login
        self.id = id
        self.avatar = avatar
        self.profileURL = profileURL
        self.followersURL = followersURL
        
    }
}

extension User {
    
    init?(json: [String : Any]) { // init User model from JSON data
        
        guard let login = json["login"] as? String else { return nil }
        let id = json["id"] as? Int ?? 0
        let avatar = json["avatar_url"] as? String ?? ""
        let profileURL = json["html_url"] as? String ?? ""
        let followersURL = json["followers_url"] as? String ?? ""
        
        self.login = login
        self.id = String(id)
        self.avatar = avatar
        self.profileURL = profileURL
        self.followersURL = followersURL + "?&per_page=100&page="

    }
    
}
