//
//  UserProfileViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

// MARK:- Protocol
/**
- Remark:- protocol that allows UI reusability.
*/
protocol HeaderSubHeaderInfo {
    var header: String { get }
    var subHeader: String { get }
}

/**
 - Remark:- viewModel displayed in the user profiles page.
 */
struct UserProfileViewModel {
    
    var userAvatar: UIImage?
    let userDataStackViewModel: UserDataStackViewModel
    let profileDescription: UserProfileDescription
    
    static var stub: UserProfileViewModel {
        UserProfileViewModel(userAvatar: UIImage(named: "sashi"),
        userDataStackViewModel: UserDataStackViewModel(photoDataInfo: UserDataViewModel(numberInfo: "100", sectionInfoTitle: "Photos"),
                                                       followersDataInfo: UserDataViewModel(numberInfo: "250", sectionInfoTitle: "Followers"),
                                                       followingDataInfo: UserDataViewModel(numberInfo: "300", sectionInfoTitle: "Following")),
        profileDescription: UserProfileDescription(userName: "Sasha", userPersonalDescription: "✈️🇲🇽🇨🇱🇯🇵🇪🇸🇻🇬"))
    }
}

/**
- Remark:- viewModel  user name and personal description
*/
struct UserProfileDescription {
    let userName: String
    let userPersonalDescription: String
}

extension UserProfileDescription: HeaderSubHeaderInfo {
    
    var header: String { userName }
    var subHeader: String { userPersonalDescription }
}
