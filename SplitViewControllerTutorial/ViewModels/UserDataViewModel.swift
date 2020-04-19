//
//  UserDataViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import Foundation

struct UserDataViewModel {
    
    let numberInfo: String
    let sectionInfoTitle: String
}

extension UserDataViewModel: HeaderSubHeaderInfo {
    
    var header: String { numberInfo }
    var subHeader: String { sectionInfoTitle }
}

struct UserDataStackViewModel {
    
    let photoDataInfo: UserDataViewModel
    let followersDataInfo: UserDataViewModel
    let followingDataInfo: UserDataViewModel
}
