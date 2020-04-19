//
//  FeedPostTableViewCell.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/4/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class FeedPostTableViewCell: GenericTableViewCell<FullPostViewModel> {
    
    @IBOutlet var headerPostContentView: HeaderPostContentView!
    @IBOutlet var postsCollectionView: HorizontalCollectionView! {
        didSet {
            postsCollectionView.setupLayoutKind(.horizontalPostsLayout(traitCollection))
        }
    }
    @IBOutlet var actionsView: FeedPostActionsView!
    
    override func setupWith(_ item: FullPostViewModel) {
        headerPostContentView.setupWith(item.headerPostViewModel)
        postsCollectionView.setupDataSourceWith(item.contents.map { HorizontalContent.post($0) })
    }
}
