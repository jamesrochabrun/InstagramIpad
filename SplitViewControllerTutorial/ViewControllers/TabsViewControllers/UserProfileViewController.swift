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
        let detailViewController = ContentDetailViewcontroller.instantiate(from: "Main")
        delegate = detailViewController
        return detailViewController
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
        
        guard let secondaryContentNavigationController = splitViewController?.secondaryViewController as? NavigationController, let secondaryContentViewController = secondaryContentNavigationController.topViewController as? ContentDetailViewcontroller else {
            let detailNavigationController = NavigationController(rootViewController: contentDetailViewController)
            splitViewController?.showDetailInNavigationControllerIfNeeded(detailNavigationController, sender: self)
            delegate?.postSelectedAt(indexPath)
            return
        }
        splitViewController?.showDetailInNavigationControllerIfNeeded(secondaryContentViewController, sender: self)
        delegate?.postSelectedAt(indexPath)
    }
}
