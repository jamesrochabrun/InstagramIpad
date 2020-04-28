//
//  FeedPostActionsView.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class FeedPostActionsView: BaseXibView {
    
    @IBOutlet private var likeButton: Button! {
        didSet {
            likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    @IBOutlet private var shareButton: Button! {
        didSet {
            shareButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        }
    }
    @IBOutlet private var commentButton: Button! {
        didSet {
            commentButton.setImage(UIImage(systemName: "message"), for: .normal)
        }
    }
    @IBOutlet private var saveButton: Button! {
        didSet {
            saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    var items: [Button]  {
        [likeButton, shareButton, commentButton, saveButton]
    }
}

