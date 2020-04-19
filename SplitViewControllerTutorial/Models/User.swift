//
//  User.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import Foundation

//"""
//  "data": {
//    "id": "1574083",
//    "username": "snoopdogg",
//    "full_name": "Snoop Dogg",
//    "profile_picture": "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg",
//    "bio": "This is my bio",
//    "website": "http://snoopdogg.com",
//    "is_business": false,
//    "counts": {
//      "media": 1320,
//      "follows": 420,
//      "followed_by": 3410
//    }
//  }
//}
//"""

struct User: Codable {
    
    let id: String
    let username: String
    let full_name: String
    let profile_picture: String
    let bio: String
    let website: String
    let is_business: Bool
    let counts: Counts
}

struct Counts: Codable {
    let media: Int
    let follows: Int
    let followed_by: Int
}
