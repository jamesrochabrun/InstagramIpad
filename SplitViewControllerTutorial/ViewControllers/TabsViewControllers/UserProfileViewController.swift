//
//  UserProfileViewController.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 3/29/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

// MARK:- Protocol
protocol UserProfileFeedSelectionDelegate: AnyObject {
    func postSelectedAt(_ indexPath: IndexPath)
}

// MARK:- Class
final class UserProfileViewController: ViewController {

    // MARK:- UI
    @IBOutlet private var feedCollectionView: GridCollectionView! {
        didSet {
            feedCollectionView.delegate = self
        }
    }
    
    lazy private var contentDetailViewController: ContentDetailViewcontroller = {
        ContentDetailViewcontroller.instantiate(from: "Main")
    }()
    
    // MARK:- Public
    weak var delegate: UserProfileFeedSelectionDelegate?
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView?.setupDataSourceWith(PostViewModel.userFeedPosts)
        feedCollectionView?.setupLayoutKind(.profile)
    }
}

// MARK:- GridCollectionViewDelegate
extension UserProfileViewController: GridCollectionViewDelegate {

    func cellDidSelect(_ indexPath: IndexPath) {
                
        guard let userProfileDelegate = delegate else {
            splitViewController?.showDetailEmbededinNavigationController(vc: contentDetailViewController, sender: self)
            delegate = contentDetailViewController
            contentDetailViewController.selectedIndexPath = indexPath
            return
        }
        userProfileDelegate.postSelectedAt(indexPath)
    }
}
