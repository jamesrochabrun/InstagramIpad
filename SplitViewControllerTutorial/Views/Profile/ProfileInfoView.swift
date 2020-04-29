//
//  ProfileInfoView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class ProfileInfoView: BaseXibView {
    
    @IBOutlet private var profileImageView: ImageView!
    @IBOutlet private var profileDataView: ProfileDataView!
    @IBOutlet private var profileDescriptionStackView: VerticalLabelsStackView!
    @IBOutlet private var editProfileButton: Button! {
        didSet {
            editProfileButton.layer.borderWidth = 1.0
            editProfileButton.layer.cornerRadius = 4.0
            editProfileButton.layer.masksToBounds = false
            editProfileButton?.layer.borderColor = Theme.buttonTint.color?.cgColor
            editProfileButton?.setTitleColor(Theme.buttonTint.color, for: .normal)
            editProfileButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setupWith(_ viewModel: UserProfileViewModel) {
        profileImageView.setImage(viewModel.userAvatar)
        profileDataView.setupWith(viewModel.userDataStackViewModel)
        profileDescriptionStackView.setupWith(viewModel.profileDescription)
    }
    
    @IBAction func editProfileTapped(_ sender: UIButton) {
        print("profile edit tapped")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView?.circle()
        profileImageView?.setupGradient(cornerRadius: profileImageView?.layer.cornerRadius ?? 0)
    }
}
