//
//  FeedPostTableViewCell.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

// MARK:- Protocol
protocol FeedPostTableViewCellDelegate: AnyObject {
    func viewAllCommentsDidTapped()
}

final class FeedPostTableViewCell: GenericTableViewCell<FullPostViewModel> {
    
    // MARK:- UI
    @IBOutlet var headerPostContentView: HeaderPostContentView!
    @IBOutlet var postsCollectionView: HorizontalCollectionView! {
        didSet {
            postsCollectionView.setupLayoutKind(.horizontalPostsLayout)
        }
    }
    @IBOutlet var actionsView: FeedPostActionsView!
    @IBOutlet var commentsLabel: PrimaryLabel! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewAllComments))
            commentsLabel.addGestureRecognizer(tapGesture)
        }
    }
    
    // MARK:- Public
    weak var delegate: FeedPostTableViewCellDelegate?
    
    // MARK:- set up
    override func setupWith(_ item: FullPostViewModel) {
        headerPostContentView.setupWith(item.headerPostViewModel)
        postsCollectionView.setupDataSourceWith(item.contents.map { HorizontalContent.post($0.content) })
    }
    
    // MARK:- Gestures
    @objc func viewAllComments(_ gesture: UITapGestureRecognizer) {
        delegate?.viewAllCommentsDidTapped()
    }
}
