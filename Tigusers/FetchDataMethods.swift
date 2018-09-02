//
//  UserFetch.swift
//  Tigusers
//
//  Created by Artur Kablak on 09/08/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import Foundation
import UIKit

enum Result <T> {
    case Success(T)
    case Error(String)
}


// Method for fetching GitHub users

struct Fetch {
    
    static func users(fromURL: String, completion: @escaping (Result<[User]>) -> ()) {
        
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
                        
            guard let data = data else {
                completion(.Error(error?.localizedDescription ?? "There are no data to show"))
                return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let jsonUsers = try? decoder.decode([User].self, from: data)
                else {
                    completion(.Error(error?.localizedDescription ?? "There are no users to show"))
                    return }
        
            
            completion(.Success(jsonUsers))
        }
        taskFetchingUsers.resume()
    }
    
}
