//
//  NotificationListUserView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class NotificationListUserView: GenericView<NotificationListItemViewModel> {
    
    @IBOutlet private var profileImageView: ImageView!
    @IBOutlet private var contentLabel: PrimaryLabel! {
        didSet {
            contentLabel.textColor = .label
        }
    }
    @IBOutlet private var postImageView: UIImageView!
    
    override func setupWith(_ item: NotificationListItemViewModel) {
        contentLabel?.text = "\(item.user.userName) \(item.comment)"
        profileImageView?.setImage(item.user.profilePicture)
        postImageView?.image = item.postImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView?.circle()
        profileImageView?.setupGradient(cornerRadius: profileImageView?.layer.cornerRadius ?? 0, lineWidth: 2.5)
    }
}
