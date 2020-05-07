//
//  UserViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/**
- Remark:- viewModel for a notification.
*/
struct NotificationListItemViewModel {
    
    let user: UserViewModel
    let comment: String
    let postImage: UIImage?
    
    static var users: [NotificationListItemViewModel] {
  
        var viewModels: [NotificationListItemViewModel] = []
        for enumerated in zip(UsersMockData.userNames, UsersMockData.comments).enumerated() {
            let photo = PostsStubData.userProfilePhotos[enumerated.offset]
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
