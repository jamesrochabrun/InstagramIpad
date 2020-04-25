//
//  ProfileDataView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class ProfileDataView: BaseXibView {
    
    @IBOutlet private var photosDataView: VerticalLabelsStackView!
    @IBOutlet private var followersView: VerticalLabelsStackView!
    @IBOutlet private var followingView: VerticalLabelsStackView!

    
    func setupWith(_ item: UserDataStackViewModel) {
        photosDataView.setupWith(item.photoDataInfo)
        followersView.setupWith(item.followersDataInfo)
        followingView.setupWith(item.followingDataInfo)
    }
}
