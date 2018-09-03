//
//  UserModel.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import Foundation

struct User: Decodable, Equatable {
    
    let login: String?
    let id: String?
    let avatar: String?
    let profileURL: String?
    let followersURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatar = "avatarUrl"
        case profileURL = "url"
        case followersURL = "followersUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try? values.decode(String.self, forKey: .login)
        id = try? values.decode(String.self, forKey: .id)
        avatar = try? values.decode(String.self, forKey: .avatar)
        profileURL = try? values.decode(String.self, forKey: .profileURL)
        followersURL = try? values.decode(String.self, forKey: .followersURL) + Config.endUrl
    }
}
