//
//  ProfileDataView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class ProfileDataView: BaseXibView {
    
    @IBOutlet private var followingView: VerticalLabelsStackView!
    @IBOutlet private var followersView: VerticalLabelsStackView!
    @IBOutlet private var photosDataView: VerticalLabelsStackView!
    
    func setupWith(_ item: UserDataStackViewModel) {
        followingView.setupWith(item.photoDataInfo)
        followersView.setupWith(item.followersDataInfo)
        followersView.setupWith(item.followingDataInfo)
    }
}
