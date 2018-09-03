//
//  UserViewModel.swift
//  Tigusers
//
//  Created by Artur Kablak on 03/09/2018.
//  Copyright © 2018 Artur Kablak. All rights reserved.
//

import Foundation

struct UserViewModel {
    
    let login: String
    let id: String
    let avatar: String
    let profileURL: String
    let followersURL: String
    
    init(user: User) {
        self.login = user.login ?? "-"
        self.id = user.id ?? "-"
        self.avatar = user.avatar ?? "-"
        self.profileURL = user.profileURL ?? "-"
        self.followersURL = user.followersURL ?? "-"
    }

}
