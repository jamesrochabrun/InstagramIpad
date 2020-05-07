//
//  MockContent.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 5/7/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/**
- Remark:- generates different kind of contents for home, search etc.
*/
struct PostsStubData {
    
    static var userProfilePhotos: [UIImage] {
        var photos: [UIImage?] = []
        for i in 0...36 {
            photos.append(UIImage(named: "post\(i)")) // personal user photos
        }
        return photos.compactMap { $0 }
    }
    
    static var homeFeedPhotos: [UIImage] {
        var photos: [UIImage?] = []
        for i in 0...36 {
            photos.append(UIImage(named: "home\(i)")) // posts of followed users
        }
        return photos.compactMap { $0 }
    }
    
    static var searchFeedPlaceholderPhotos: [UIImage] {
        var photos: [UIImage?] = []
        for i in 0...36 {
            photos.append(UIImage(named: "search\(i)")) // random posts
        }
        return photos.compactMap { $0 }
    }
}


/**
- Remark:- Content for notifications.
*/
struct UsersMockData {
    
    static let userNames = ["Alex", "Alana", "Bryan", "Kevin", "Marilyn", "Sasha", "Isabela", "James", "Melissa", "Vince", "Antonio", "zizou", "Monkey", "Mandalorian", "Leia", "LukeSkyWalker", "DarthVader2000", "Messi", "Zidane"]
    
    static let comments = ["commented: Love it 😎",
                           "commented: Amazing wish I am there 💙",
                           "liked your comment: Ha no idea!",
                           "liked your comment: Love you 💖",
                           "liked your comment: Come to visit soon! will be there in August",
                           "liked your comment: your rock 🔥!",
                           "liked your comment: Are you wearing pants on that photo? 😅",
                           "liked your comment: Liked your photo",
                           "commented: you go girl ✌🏼",
                           "commented That is so exciting! 🙌",
                           "commentedt: Wishing you the best, take care",
                           "commented: Love this 🤗",
                           "commented: Fantastic times, see you soon ",
                           "commented: OMG Sash! 💖",
                           "liked your comment: Liked your photo",
                           "commented: Felicidades! ",
                           "liked your comment: Liked your photo",
                           "commented: I will be there on summer! ☀️",
                           "liked your comment: Liked your photo"]
}
