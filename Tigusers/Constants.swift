//
//  Constants.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import Foundation
import UIKit

struct Config {
    
    // URL constants
    static let session = URLSession.shared
    static let defaultURL = "https://api.github.com/users?since=0&per_page=100" // link for fetching first 100 git users
    static let name = "Tigusers"
    
    // Cell name
    static let userCell = "userCell"
    static let followerSegue = "toFollowers"
    
    
}

