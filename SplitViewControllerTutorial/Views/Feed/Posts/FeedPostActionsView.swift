//
//  FeedPostActionsView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class FeedPostActionsView: BaseXibView {
    
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var shareButton: UIButton!
    @IBOutlet private var commentButton: UIButton!
    @IBOutlet private var saveButton: UIButton!
    
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

