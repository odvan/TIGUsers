//
//  UserFetch.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import Foundation
import UIKit

enum Result <T>{ // completion handler for fetching method
    case Success(T)
    case Error(String)
}


// Method for fetching GitHub users

struct Fetch {
    
    static func users(fromURL: String, completion: @escaping (Result<[User]>) -> ()) { // fetching users
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard let url = URL(string: fromURL) else {
            completion(.Error("Invalid URL, we can't update your feed"))
            print("Invalid URL, we can't update your feed")
            return
        }
        
        let urlRequest = URLRequest(url: url)
//        urlRequest.setValue(Config.name, forHTTPHeaderField: "User-Agent") // required header for Git API
        let taskFetchingUsers = Config.session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                completion(.Error(error!.localizedDescription))
                print("error while fecthing data: \(error!.localizedDescription)")
                return
            }
            print("🔶 \(response!)")
            
            var users: [User] = []
            
            guard let data = data else {
                completion(.Error(error?.localizedDescription ?? "There are no data to show"))
                return }
            
            guard let jsonUsers = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : Any]]
                else {
                    completion(.Error(error?.localizedDescription ?? "There are no users to show"))
                    return }
            
            for user in jsonUsers {
                if let someUser = User(json: user) {
                    users.append(someUser)
                }
            }
            print("users: \(users)")
            completion(.Success(users))
        }
        taskFetchingUsers.resume()
    }
    
}
