//
//  FeedPostActionsView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class FeedPostActionsView: BaseXibView {
    
    @IBOutlet private var likeButton: UIButton! {
        didSet {
            likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    @IBOutlet private var shareButton: UIButton! {
        didSet {
            shareButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        }
    }
    @IBOutlet private var commentButton: UIButton! {
        didSet {
            commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        }
    }
    @IBOutlet private var saveButton: UIButton! {
        didSet {
            saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    var items: [UIButton]  {
        [likeButton, shareButton, commentButton, saveButton]
    }
    
    override func setUpViews() {
        items.forEach { $0.tintColor = Instagram.tintColor(traitCollection) }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.isDifferentToPrevious(previousTraitCollection) else { return }
        items.forEach { $0.tintColor = Instagram.tintColor(traitCollection) }
    }
}

