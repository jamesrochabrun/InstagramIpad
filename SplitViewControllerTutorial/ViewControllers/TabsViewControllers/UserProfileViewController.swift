//
//  UserProfileViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class UserProfileViewController: UIViewController {
    
    @IBOutlet private var userProfileView: ProfileInfoView! 
    
    @IBOutlet private var feedCollectionView: GridCollectionView! {
        didSet {
            feedCollectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTo(traitCollection)
        let profileInfoViewModel = UserProfileViewModel(userAvatar: UIImage(named: "sashi"),
                                                        userDataStackViewModel: UserDataStackViewModel(photoDataInfo: UserDataViewModel(numberInfo: "100", sectionInfoTitle: "Photos"),
                                                                                                       followersDataInfo: UserDataViewModel(numberInfo: "250", sectionInfoTitle: "Followers"),
                                                                                                       followingDataInfo: UserDataViewModel(numberInfo: "300", sectionInfoTitle: "Following")),
                                                        profileDescription: UserProfileDescription(userName: "Sasha", userPersonalDescription: "✈️🇲🇽🇨🇱🇯🇵🇪🇸🇻🇬"))
        userProfileView?.setupWith(profileInfoViewModel)
        feedCollectionView?.setupDataSourceWith(PostViewModel.userFeedPosts)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)
         guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
         updateTo(traitCollection)
     }
     
    private func updateTo(_ traitCollection: UITraitCollection) {
        feedCollectionView?.setupLayoutKind(.profile(traitCollection))
        view.backgroundColor = Instagram.mainContainerBackgroundColor(traitCollection)
    }
}

extension UserProfileViewController: GridCollectionViewDelegate {

    func cellDidSelect(_ model: PostViewModel) {
        
        let contentViewController = ContentDetailViewcontroller.instantiate(from: "Main")
        splitViewController?.showDetailEmbededinNavigationController(vc: contentViewController, sender: self)
    }
}
