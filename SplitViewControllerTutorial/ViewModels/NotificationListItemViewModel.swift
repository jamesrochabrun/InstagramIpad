//
//  UserViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

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




struct NotificationListItemViewModel {
    
    let user: UserViewModel
    let comment: String
    let postImage: UIImage?
    
    static var users: [NotificationListItemViewModel] {
  
        var viewModels: [NotificationListItemViewModel] = []
        for enumerated in zip(UsersMockData.userNames, UsersMockData.comments).enumerated() {
            let photo = PostMockData.userProfilePhotos[enumerated.offset]
            let userName = enumerated.element.0
            let comment = enumerated.element.1
            let user = UserViewModel(id: "", userName: userName, profilePicture: UIImage(named: "prof\(enumerated.offset)"))
            viewModels.append(NotificationListItemViewModel(user: user, comment: comment, postImage: photo))
        }
        return viewModels
    }
}

extension NotificationListItemViewModel: Equatable {
    
}
