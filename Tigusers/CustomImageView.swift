//
//  CustomImageView.swift
//  FootballResultsThird
//
//  Created by Artur Kablak on 18/05/17.
//  Copyright © 2017 Artur Kablak. All rights reserved.
//

import UIKit

let imgCache = NSCache<AnyObject, AnyObject>()


class CustomImageView: UIImageView {
    
    var checkURL: String?
    
    func showAvatar(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
                
        image = nil
        checkURL = link
        
        if let cachedImg = imgCache.object(forKey: link as AnyObject) {
            image = cachedImg as? UIImage
        } else {
            guard
                let encoded = link.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                let url = URL(string: encoded)
                else { return }
            
            contentMode = mode
            
            let task = Config.session.dataTask(with: url) { (data, response, error) in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil
                    
                    else { return }
                
                //print("\(response)")
                
                if let image = UIImage(data: data) {
                    imgCache.setObject(image, forKey: link as AnyObject)
                    
                    DispatchQueue.main.async() { () -> Void in
                        if self.checkURL == link {
                            self.image = image
                        } else {
                            print("image ignored because of wrong URL")
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
