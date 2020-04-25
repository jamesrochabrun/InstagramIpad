//
//  UserProfileViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

struct UserViewModel {
    
    let id: String
    let userName: String
    let profilePicture: UIImage?
}

extension UserViewModel: Equatable {
    
    
}

protocol HeaderSubHeaderInfo {
    var header: String { get }
    var subHeader: String { get }
}

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

struct UserProfileDescription {
    let userName: String
    let userPersonalDescription: String
}

extension UserProfileDescription: HeaderSubHeaderInfo {
    
    var header: String { userName }
    var subHeader: String { userPersonalDescription }
}
