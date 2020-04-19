//
//  StoryVideoCollectionViewCell.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/3/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/// Used at home for large preview story.

final class StoryVideoCollectionViewCell: GenericCollectionViewCell<StoryVideoCoverViewModel> {
    
    static let profileCoverSize = CGSize(width: 75.0, height: 115.0)
    
    let videoImageCoverView: ImageView = {
        ImageView()
    }()
    
    let userOwnerProfileCoverView: CircularCoverWithTitleView = {
        CircularCoverWithTitleView()
    }()
    
    lazy var bottomGradient: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = CGRect.zero
       return gradientLayer
    }()
    
    override func setupSubviews() {
        layer.cornerRadius = 15.0
        layer.masksToBounds = false
        clipsToBounds = true
        contentView.addSubview(videoImageCoverView)
        contentView.addSubview(userOwnerProfileCoverView)
        videoImageCoverView.fillSuperview()
        
        userOwnerProfileCoverView.anchor(top: nil,
                                         leading: nil,
                                         bottom: contentView.bottomAnchor,
                                         trailing: nil,
                                         padding: .init(top: 0, left: 0, bottom: 8, right: 0), size: .init(width: Self.profileCoverSize.width, height: Self.profileCoverSize.height))
        userOwnerProfileCoverView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        layoutIfNeeded()
        videoImageCoverView.layer.addSublayer(bottomGradient)
        bottomGradient.frame = .init(x: 0, y: frame.height - Self.profileCoverSize.height, width: frame.width, height: Self.profileCoverSize.height)
    }
    
    override func setupWith(_ item: StoryVideoCoverViewModel) {
        videoImageCoverView.setImage(item.videoCover)
        let userprofileCover = UserStoryCoverViewModel(userName: item.userOwner.userName, userCover: item.userOwner.cover)
        userOwnerProfileCoverView.setupWith(userprofileCover)
    }
}
