//
//  UserDataViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import Foundation

/**
- Remark:- viewModel displayes a single category  followers, following, posts or  counts.
*/
struct UserDataViewModel {
    
    let numberInfo: String
    let sectionInfoTitle: String
}

extension UserDataViewModel: HeaderSubHeaderInfo {
    var header: String { numberInfo }
    var subHeader: String { sectionInfoTitle }
}

/**
- Remark:- viewModel displayes followers, following and posts in a stackview.
*/
struct UserDataStackViewModel {
    
    let photoDataInfo: UserDataViewModel
    let followersDataInfo: UserDataViewModel
    let followingDataInfo: UserDataViewModel
}
