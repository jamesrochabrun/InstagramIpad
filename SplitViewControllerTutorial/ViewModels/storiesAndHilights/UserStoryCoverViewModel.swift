//
//  UserStoryCoverViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 5/7/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/**
- Remark:- viewModel used in story cover UI, where the cell displays the users profile image.
*/

struct UserStoryCoverViewModel {
    let userName: String
    let userCover: UIImage?
    let hilightBorder: BorderKind = .gradient
    
    static var userProfileStoryCovers: [UserStoryCoverViewModel] {
        var covers: [UserStoryCoverViewModel] = []
        for enumerated in UsersMockData.userNames.enumerated() {
            let userCover = UserStoryCoverViewModel(userName: enumerated.element, userCover: UIImage(named: "prof\(enumerated.offset)"))
            covers.append(userCover)
        }
        return covers
    }
}

extension UserStoryCoverViewModel: CircularCoverDisplayWithText {
    var title: String { userName }
    var cover: UIImage? { userCover }
    var borderKind: BorderKind { hilightBorder }
}
