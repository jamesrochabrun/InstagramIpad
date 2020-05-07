//
//  UserViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 5/7/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/**
- Remark:- viewModel for a basic info of an user.
*/
struct UserViewModel {
    
    let id: String
    let userName: String
    let profilePicture: UIImage?
}

extension UserViewModel: Equatable {
    
}
