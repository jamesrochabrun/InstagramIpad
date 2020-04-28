//
//  UserProfileViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

final class UserProfileViewController: ViewController {
        
    @IBOutlet private var feedCollectionView: GridCollectionView! {
        didSet {
            feedCollectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView?.setupDataSourceWith(PostViewModel.userFeedPosts)
        feedCollectionView?.setupLayoutKind(.profile)
    }
}

extension UserProfileViewController: GridCollectionViewDelegate {

    func cellDidSelect(_ indexPath: IndexPath) {
        
        let contentViewController = ContentDetailViewcontroller.instantiate(from: "Main")
        splitViewController?.showDetailEmbededinNavigationController(vc: contentViewController, sender: self)
        contentViewController.selectedIndexPath = indexPath
    }
}
