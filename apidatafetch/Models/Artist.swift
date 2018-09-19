//
//  Artist.swift
//  apidatafetch
//
//  Created by Ishmam Islam on 16/7/18.
//  Copyright © 2018 Ishmam Islam. All rights reserved.
//

import Foundation
import UIKit

struct Artist{
    let name: String
    let bio: String
    
    init(name: String, bio: String){
        self.name = name
        self.bio = bio
    }
    
    static func artistsFromData(dataString:String) -> [Artist]{
        var artists = [Artist]()
        guard let data = dataString.data(using: .utf8) else{
          return artists
        }
    
    do {
        guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
        return artists
    }
    
    guard let artistObjects = rootObject["artists"] as? [[String: AnyObject]] else {
        return artists
    }
    
    for artistObject in artistObjects {
        if let name = artistObject["name"] as? String, let bio = artistObject["bio"] as? String{
    
    let artist = Artist(name: name, bio: bio)
    artists.append(artist)
            }
        }
    } catch {
        return artists
    }
    return artists
}

    static func artistsFromBundle() -> [Artist] {
        var artists = [Artist]()
        
        guard let url = Bundle.main.url(forResource: "artists", withExtension: "json") else {
            return artists
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return artists
            }
            
            guard let artistObjects = rootObject["artists"] as? [[String: AnyObject]] else { return artists }
            
            for artistObject in artistObjects {
                if let name = artistObject["name"] as? String,
                    let _ = artistObject["bio"] {
                    _ = Artist(name: name, bio: <#String#>)
                }
            }
        }
    }
}
