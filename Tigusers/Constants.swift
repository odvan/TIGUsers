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
    static let endUrl = "?&per_page=100&page="
    static let defaultURL = "https://api.github.com/users?since=0" + endUrl
    
    // VC name & id
    static let name = "Tigusers"
    static let mainTVC = "mainTVC"
    
    // Cell name
    static let userCell = "userCell"    
}

