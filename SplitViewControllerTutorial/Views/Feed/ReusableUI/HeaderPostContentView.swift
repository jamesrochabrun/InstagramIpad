//
//  HeaderPostContentView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

struct HeaderPostViewModel {
    let user: UserViewModel
    let location: String
}

final class HeaderPostContentView: BaseXibView {
    
    @IBOutlet private var profileImageView: ImageView!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var actionButton: UIButton!
    
    override func setUpViews() {
        actionButton?.tintColor = Instagram.tintColor(traitCollection)
    }
    
    func setupWith(_ viewModel: HeaderPostViewModel) {
        usernameLabel?.text = viewModel.user.userName
        locationLabel?.text = viewModel.location
        profileImageView?.setImage(viewModel.user.profilePicture)
    }
    
    @IBAction func actionButtonDidTapped(_ sender: UIButton) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView?.circle()
        profileImageView?.setupGradient(cornerRadius: profileImageView?.layer.cornerRadius ?? 0, lineWidth: 1.5)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
        actionButton?.tintColor = Instagram.tintColor(traitCollection)
    }
}

